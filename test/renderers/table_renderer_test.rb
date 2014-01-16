require 'test_helper'

class TableRendererTest < ActionView::TestCase
  fixtures :all
  
  def builder
    @builder ||= TableView::TableBuilder.new(Post.scoped).tap do |t|
      t.column :title
      t.column :content
    end
  end

  def table_renderer
    @table_renderer ||= TableView::Renderers::TableRenderer.new(builder)
  end

  def body_renderer
    @body_renderer ||= TableView::Renderers::BodyRenderer.new(builder)
  end

  def header_renderer
    @header_renderer ||= TableView::Renderers::HeaderRenderer.new(builder)
  end

  teardown {@builder = @table_renderer = @body_renderer = @header_renderer = nil}

  test "renders table" do
    assert_dom_equal '<table>' + header_renderer.to_html + body_renderer.to_html + '</table>', table_renderer.to_html
  end
end
