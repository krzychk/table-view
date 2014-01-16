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
        content_tag(:tr, columns_html(record))
      end

      def columns_html record
        columns_html = "".html_safe
        builder.columns.each {|column| columns_html << column_html(record, column)}
        columns_html
      end

      def column_html record, column
        content_tag(:td, cell_contents(record, column))
      end

      def cell_contents record, column
        record.send(column.name)
      end
    end
  end
end