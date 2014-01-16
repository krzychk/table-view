module TableView
  module Renderers
    class BodyCellRenderer < BaseRenderer
      attr_reader :column, :record

      def initialize builder, column, record
        super(builder)
        @column = column
        @record = record
      end

      def to_html
        content_tag(:td, cell_contents)
      end

      private

      def cell_contents
        if column.block_given?
          capture { column.block.call(record) }
        else
          record.send(column.name)
        end
      end
    end
  end
end