module TableView
  module Helpers
    def table_for relation, attributes={}
      builder = TableView::TableBuilder.new(relation, attributes)
      yield builder
      TableView::Renderers::TableRenderer.new(builder).to_html
    end
  end
end

ActionView::Base.send :include, TableView::Helpers