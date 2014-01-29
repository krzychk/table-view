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
        return unless column.sum?
        value = builder.sum(column).to_s
        if column.format
          context.send(column.format, value)
        else
          value
        end
      end
    end 
  end
end