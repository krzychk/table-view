module TableView
  module Renderers
    class BodyRenderer < BaseRenderer
      def to_html
        content_tag(:tbody, rows_html)
      end

      private

      def rows_html
        rows_html = "".html_safe
        builder.records.each {|record| rows_html << record_html(record)}
        rows_html
      end

      def record_html record
        content_tag(:tr, columns_html(record), attributes)
      end

      def columns_html record
        columns_html = "".html_safe
        builder.columns.each {|column| columns_html << column_html(record, column)}
        columns_html
      end

      def column_html record, column
        TableView::Renderers::BodyCellRenderer.new(builder, column, record).to_html
      end

      def attributes
        attributes = {}
        attributes[:class] = builder.row_classes.join(" ") if builder.row_classes.any?
        attributes
      end
    end
  end
end