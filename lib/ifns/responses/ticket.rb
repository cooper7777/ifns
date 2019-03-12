module Ifns
  module Responses
    class Ticket
      attr_reader :response

      def initialize(response)
        @response = response
      end

      delegate :body, :status, to: :response

      def good?
        status == 200
      end

      def retry?
        processing? || gone? || internal_error? || goods.blank? || not_found? || accepted?
      end

      def processing?
        status == 406 || not_found? || goods.blank?
      end

      def error?
        status == 400
      end

      def goods
        @goods ||= begin
          return if items_blank?

          devider = 100.0
          items = body[:receipt][:items].map(&:dup)
          items.map do |good|
            good[:price] = (good[:price] / devider)
            good[:sum] = (good[:sum] / devider)
            good
          end
        end
      end

      def inn
        body.try(:[], :receipt).try(:[], :userInn)
      end

      def ticket
        body[:receipt]
      end

      private

      def items_blank?
        ticket.try(:[], :items).blank?
      end

      def gone?
        status == 410
      end

      def internal_error?
        status >= 500
      end

      def not_found?
        status == 404
      end

      def accepted?
        status == 202
      end
    end
  end
end
