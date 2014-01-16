module TableView
  module Renderers
    class HeaderRenderer
      include ActionView::Helpers::TagHelper

      attr_reader :builder

      def initialize builder
        @builder = builder
      end

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
        content_tag(:th, column_title(column))
      end

      def column_title column
        builder.klass.human_attribute_name(column.name)
      end
    end
  end
end