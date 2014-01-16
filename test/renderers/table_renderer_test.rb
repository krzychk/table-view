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

  def table_html
    HTML::Document.new(table_renderer.to_html).root
  end

  teardown do 
    @builder = @table_renderer = @body_renderer = @header_renderer = nil
    TableView.setup do |config|
      config.default_table_classes = []
    end
  end

  test "renders table" do
    assert_dom_equal '<table>' + header_renderer.to_html + body_renderer.to_html + '</table>', table_renderer.to_html
  end

  test "table html classes" do
    builder.classes = "my-table"
    assert_select table_html, "table" do
      assert_select "[class=my-table]"
    end
  end

  test "default table classes" do
    TableView.setup do |config|
      config.default_table_classes = ["default-class"]
    end
    assert_select table_html, "table" do
      assert_select "[class=default-class]"
    end
  end
end
