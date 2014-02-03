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
        "?#{{
          :sc => column.name,
          :sd => 'asc'
        }.to_param}"
      end

      def sortable_arrow
        if context.params[:sc] == column.name.to_s && context.params[:sd] == 'asc'
          " &#9660;"
        elsif context.params[:sc] == column.name.to_s && context.params[:sd] == 'desc'
          " &#9650;"
        else
          ""
        end
      end

      def record_attribute_name
        if column.name
          builder.klass.human_attribute_name(column.name)
        end
      end
    end
  end
end