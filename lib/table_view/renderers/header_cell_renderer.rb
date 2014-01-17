module TableView
  module Renderers
    class HeaderCellRenderer < BaseRenderer
      attr_reader :column

      def initialize builder, context, column
        super(builder, context)
        @column = column
      end

      def to_html
        content_tag(:th, cell_contents, column.header_attributes)
      end

      private

      def cell_contents
        column.options[:label] || record_attribute_name
      end

      def record_attribute_name
        if column.name
          builder.klass.human_attribute_name(column.name)
        end
      end
    end
  end
end