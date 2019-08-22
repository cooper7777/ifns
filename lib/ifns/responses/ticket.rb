module Ifns
  module Responses
    class Ticket < Base
      def retry?
        processing? || gone? || internal_error? || goods.blank? || not_found? || accepted?
      end

      def processing?
        status == 406 || not_found? || goods.blank?
      end

      def error?
        incorrect_params?
      end

      def goods
        @goods ||= begin
          return if items_blank?

          devider = 100.0
          items = body[:receipt][:items].map(&:dup)
          items.map do |good|
            good[:name] = good[:name].try(:squish)
            good[:price] = (good[:price].to_f / devider)
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
    end
  end
end
