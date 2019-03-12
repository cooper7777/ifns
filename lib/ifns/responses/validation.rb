module Ifns
  module Responses
    class Validation < Base
      def valid?
        good?
      end

      def invalid?
        status == 406 || incorrect_params?
      end

      def retry?
        gone? || internal_error? || accepted?
      end
    end
  end
end
