module TableView
  module Renderers
    class HeaderRenderer < BaseRenderer
      def to_html
        content_tag(:thead, content_tag(:tr, columns_html))
      end

      private

      def columns_html
        columns_html = "".html_safe
        builder.columns.each {|column| columns_html << column_html(column)}
        columns_html
      end

      def column_html column
        TableView::Renderers::HeaderCellRenderer.new(builder, context, column).to_html
      end
    end
  end
end