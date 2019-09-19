module Ifns
  module Responses
    class Ticket < Base
      def goods
        @goods ||= begin
          return if items_blank?

          devider = 100.0
          items = body[:receipt][:items].map(&:dup)
          items.map do |good|
            good[:name] = good[:name].try(:squish)
            good[:price] = (good[:price].to_f / devider)
            good[:sum] = (good[:sum].to_f / devider)
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
