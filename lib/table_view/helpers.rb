module TableView
  module Helpers
    def table_for relation
      builder = TableView::TableBuilder.new(relation)
      yield builder
      TableView::Renderers::TableRenderer.new(builder).to_html
    end
  end
end

ActionView::Base.send :include, TableView::Helpers