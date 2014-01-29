module TableView
  module Renderers
    class FooterCellRenderer < BaseRenderer
      attr_reader :column

      def initialize builder, context, column
        super(builder, context)
        @column = column
      end

      def to_html
        content_tag(:td, cell_contents)
      end

      private

      def cell_contents
        builder.sum(column) if column.sum?
      end
    end 
  end
end