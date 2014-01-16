module TableView
  module Renderers
    class TableRenderer < BaseRenderer
      def to_html
        content_tag(:table, header_renderer.to_html + body_renderer.to_html, attributes)
      end

      private

      def attributes
        attributes = {}
        attributes[:class] = builder.classes.join(" ") if builder.classes.any?
        attributes
      end

      def header_renderer
        @header_renderer ||= TableView::Renderers::HeaderRenderer.new(builder)
      end

      def body_renderer
        @body_renderer ||= TableView::Renderers::BodyRenderer.new(builder)
      end
    end
  end
end