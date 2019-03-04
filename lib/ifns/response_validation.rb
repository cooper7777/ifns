module Ifns
  class ResponseValidation
    attr_reader :response

    def initialize(response)
      @response = response
    end

    delegate :body, :status, to: :response

    def valid?
      status == 200
    end

    def invalid?
      status == 406 || incorrect_params?
    end

    def retry?
      gone? || internal_error?
    end

    private

    def incorrect_params?
      status == 400
    end

    def gone?
      status == 410
    end

    def internal_error?
      status >= 500
    end
  end
end
