module TableView
  module Renderers
    class BodyRenderer < BaseRenderer
      def to_html
        @has_rows = false
        content_tag(:tbody, rows_html)
      end

      private

      def rows_html
        rows_html = "".html_safe
        builder.records.each {|record| rows_html << record_html(record)}
        rows_html << no_records_row unless @has_rows
        rows_html
      end

      def record_html record
        @has_rows = true
        content_tag(:tr, columns_html(record), attributes(record))
      end

      def columns_html record
        columns_html = "".html_safe
        builder.columns.each {|column| columns_html << column_html(record, column)}
        columns_html
      end

      def column_html record, column
        TableView::Renderers::BodyCellRenderer.new(builder, context, column, record).to_html
      end

      def attributes record
        attributes = {}
        attributes[:class] = row_classes(record)
        attributes
      end

      def row_classes record
        if builder.row_classes.is_a? Proc
          builder.row_classes.call(record)
        else
          builder.row_classes.join(" ") if builder.row_classes.any?
        end
      end

      def no_records_row
        content_tag(:tr, content_tag(:td, builder.no_records_label, :colspan => builder.columns.length))
      end
    end
  end
end