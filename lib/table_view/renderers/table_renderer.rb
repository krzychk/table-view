module TableView
  module Renderers
    class TableRenderer < BaseRenderer
      def to_html
        content_tag(:table, header_renderer.to_html + body_renderer.to_html + footer_html, builder.attributes)
      end

      private

      def header_renderer
        @header_renderer ||= TableView::Renderers::HeaderRenderer.new(builder, context)
      end

      def body_renderer
        @body_renderer ||= TableView::Renderers::BodyRenderer.new(builder, context)
      end

      def footer_html
        if builder.has_sums?
          footer_renderer.to_html
        end
      end

      def footer_renderer
        @footer_renderer ||= TableView::Renderers::FooterRenderer.new(builder, context)
      end
    end
  end
end