module Ifns
  module Responses
    class Cached < Base
      def initialize(id, cached)
        @id = id
        @cached = cached
      end

      def response
        OpenStruct.new(status: 200, body: { id: id, cached: cached })
      end
    end
  end
end
