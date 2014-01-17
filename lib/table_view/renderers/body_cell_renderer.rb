module TableView
  module Renderers
    class BodyCellRenderer < BaseRenderer
      attr_reader :column, :record

      def initialize builder, context, column, record
        super(builder, context)
        @column = column
        @record = record
      end

      def to_html
        content_tag(:td, cell_contents, attributes)
      end

      private

      def cell_contents
        if column.block_given?
          context.capture { column.block.call(record) }
        else
          format(record.send(column.name))
        end
      end

      def attributes
        Hash[column.body_attributes.map {|k,v| [k, v.is_a?(Proc) ? v.call(record) : v]}]
      end

      def format value
        if column.format
          context.send(column.format, value)
        elsif value.respond_to?(:strftime)
          I18n.l(value)
        elsif value === true || value === false
          I18n.t([TableView.i18n_boolean, value.to_s].compact.join('.'))
        else
          value
        end
      end
    end
  end
end