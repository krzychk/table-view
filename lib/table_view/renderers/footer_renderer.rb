module TableView
  module Renderers
    class FooterRenderer < BaseRenderer
      def to_html
        content_tag(:tfoot, content_tag(:tr, cells_html))
      end

      private

      def cells_html
        cells_html = "".html_safe
        builder.columns.each {|column| cells_html << cell_html(column)}
        cells_html
      end

      def cell_html column
        TableView::Renderers::FooterCellRenderer.new(builder, context, column).to_html
      end
    end
  end
end