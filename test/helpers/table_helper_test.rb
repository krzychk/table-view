require 'test_helper'

class TableHelperTest < ActionView::TestCase
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

  test "table_for helper method" do
    assert_dom_equal(table_renderer.to_html, table_for(Post.scoped) do |t|
      t.column :title
      t.column :content
    end)
  end
end
