module TableView
  module Renderers
    class HeaderCellRenderer < BaseRenderer
      attr_reader :column

      def initialize builder, context, column
        super(builder, context)
        @column = column
      end

      def to_html
        content_tag(:th, cell_contents, column.header_attributes)
      end

      private

      def cell_contents
        if column.sortable
          content_tag(:a, sortable_content_text, :href => sort_link_path)
        else
          content_text
        end
      end

      def content_text
        column.options[:label] || record_attribute_name
      end

      def sortable_content_text
        "#{CGI::escapeHTML(content_text)}#{sortable_arrow}".html_safe
      end

      def sort_link_path
        "?#{context.request.query_parameters.merge({
          "sc" => column.name,
          "sd" => sorted_ascending? ? 'desc' : 'asc'
        }).to_param}"
      end

      def sortable_arrow
        if sorted_ascending?
          " &#9650;"
        elsif sorted_descending?
          " &#9660;"
        else
          ""
        end
      end

      def sorted_ascending?
        context.params[:sc] == column.name.to_s && context.params[:sd] == 'asc'
      end

      def sorted_descending?
        context.params[:sc] == column.name.to_s && context.params[:sd] == 'desc'
      end

      def record_attribute_name
        if column.name
          builder.klass.human_attribute_name(column.name)
        end
      end
    end
  end
end