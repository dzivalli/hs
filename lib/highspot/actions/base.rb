module Highspot
  module Actions
    class Base
      attr_reader :source, :changes

      def initialize(source:, changes:)
        @source = source
        @changes = changes
      end

      def perform
        raise NotImplementedError
      end

      private

      def find_by_id(item_name, id)
        source[item_name].find { |item| item[:id] == id }
      end
    end
  end
end
