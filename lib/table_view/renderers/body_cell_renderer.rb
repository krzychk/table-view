module TableView
  module Renderers
    class BodyCellRenderer < BaseRenderer
      attr_reader :column, :record

      def initialize builder, context, column, record
        super(builder, context)
        @column = column
        @record = record
        @link_created = false
      end

      def to_html
        content_tag(:td, cell_contents, attributes)
      end

      private

      def cell_contents
        contents = if column.block_given?
          context.capture { column.block.call(record) }
        else
          format(record.send(column.name))
        end
        contents = link(contents) if builder.link_to && !contents.html_safe?
        contents
      end

      def attributes
        attributes = Hash[column.body_attributes.map {|k,v| [k, v.is_a?(Proc) ? v.call(record) : v]}]
        if attributes[:class]
          attributes[:class] += " #{builder.link_cell_class}"
        else
          attributes[:class] = builder.link_cell_class
        end if @link_created
        attributes
      end

      def format value
        value = I18n.t("#{column.translate}.#{value}") if column.translate && value
        if column.format
          context.send(column.format, value)
        elsif value.respond_to?(:join)
          value.map(&column.label_method).join(", ")
        elsif value.respond_to?(:strftime)
          I18n.l(value)
        elsif value === true || value === false
          I18n.t([TableView.i18n_boolean, value.to_s].compact.join('.'))
        else
          value
        end
      end

      def link contents
        @link_created = true
        path_segments = builder.link_to.is_a?(Array) ? builder.link_to.clone : [builder.link_to]
        path_segments.map! {|segment| segment == :record ? record : segment}
        context.link_to(contents, path_segments, builder.link_attributes)
      end
    end
  end
end