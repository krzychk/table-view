module TableView
  module Renderers
    class HeaderCellRenderer < BaseRenderer
      attr_reader :column

      def initialize builder, column
        super(builder)
        @column = column
      end

      def to_html
        content_tag(:th, cell_contents)
      end

      private

      def cell_contents
        column.options[:label] || builder.klass.human_attribute_name(column.name)
      end
    end
  end
end