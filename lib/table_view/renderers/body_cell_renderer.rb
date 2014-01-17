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
        content_tag(:td, cell_contents, attributes)
      end

      private

      def cell_contents
        if column.block_given?
          capture { column.block.call(record) }
        else
          record.send(column.name)
        end
      end

      def attributes
        Hash[column.body_attributes.map {|k,v| [k, v.is_a?(Proc) ? v.call(record) : v]}]
      end
    end
  end
end