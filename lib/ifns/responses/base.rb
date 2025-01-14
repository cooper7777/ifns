module Ifns
  module Responses
    class Base
      attr_reader :response, :cached, :id

      delegate :body, :status, to: :response

      def initialize(response)
        @response = response
      end

      def valid?
        good?
      end

      def invalid?
        incorrect_fpd? || incorrect_params?
      end

      def retry?
        gone? || accepted? || not_found?
      end

      def good?
        status == 200
      end

      def gone?
        status == 410
      end

      def internal_error?
        status >= 500 && status != 545 && status != 544 && status != 546
      end

      def not_found?
        status == 404 || status == 455 || status == 545 || status == 544 || status == 546
      end

      def accepted?
        status == 202
      end

      def incorrect_params?
        status == 400
      end

      def rate_limit_exceeded?
        status == 429
      end

      def incorrect_fpd?
        [406, 454, 452, 453, 456].include? status
      end
    end
  end
end
