module Ifns
  class Client
    attr_reader :data

    def initialize(options)
      @data = OpenStruct.new(options)
      validate_data
    end

    def params
      { fn: data.fn, fd: data.fd, fpd: data.fpd, sum: data.sum, date: data.date, type_operation: data.type_operation }
    end

    def create_validation
      caching(key: "ifns:validation_id:#{data.id}", expire: 60.seconds) do
        connection.post('/api/v1/validations') do |req|
          req.headers['Content-Type'] = 'application/json'
          req.headers['X-Auth-Token'] = Ifns.configuration.token
          req.body = params.to_json
        end
      end
    end

    def find_validation
      response = connection.get("/api/v1/validations/#{create_validation[:id]}") do |req|
        req.headers['X-Auth-Token'] = Ifns.configuration.token
      end
      ResponseValidation.new(response)
    end

    def create_ticket
      caching(key: "ifns:ticket_id:#{data.id}", expire: 60.seconds) do
        connection.post('/api/v1/tickets') do |req|
          req.headers['Content-Type'] = 'application/json'
          req.headers['X-Auth-Token'] = Ifns.configuration.token
          req.body = params.to_json
        end
      end
    end

    def find_ticket
      response = connection.get("/api/v1/tickets/#{create_ticket[:id]}") do |req|
        req.headers['X-Auth-Token'] = Ifns.configuration.token
      end
      ResponseTicket.new(response)
    end

    private

    def connection
      @connection ||= Faraday.new(url: Ifns.configuration.host) do |faraday|
        faraday.response :json, parser_options: { symbolize_names: true }
        faraday.use Faraday::Request::UrlEncoded
        faraday.use Faraday::Response::Logger, Ifns.configuration.logger, bodies: true
        faraday.options.open_timeout = 2
        faraday.options.timeout = 5
        faraday.adapter :net_http
      end
    end

    def caching(options)
      if Redis.current.get(options[:key]).present?
        { id: Redis.current.get(options[:key]), cached: true }
      else
        response = yield
        return { id: nil, cached: false } unless response.status == 200

        Redis.current.set(options[:key], response.body[:id], ex: options[:expire])
        { id: Redis.current.get(options[:key]), cached: false }
      end
    end

    def validate_data
      diff = %i[id fn fd fpd sum date type_operation] - data.to_h.keys
      raise KeyError, "Missing key #{diff.join(', ')}" if diff.count > 0
    end
  end
end
