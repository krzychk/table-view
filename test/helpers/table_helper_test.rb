require 'test_helper'

class TableHelperTest < ActionView::TestCase
  fixtures :all

  def builder
    @builder ||= TableView::TableBuilder.new(Post.all).tap do |t|
      t.column :title
      t.column :content
    end
  end

  def table_renderer
    @table_renderer ||= TableView::Renderers::TableRenderer.new(builder, self)
  end

  test "table_for helper method" do
    assert_dom_equal(table_renderer.to_html, table_for(Post.all) do |t|
      t.column :title
      t.column :content
    end)
  end

  test "attributes" do
    table_for(Post.all, :id => 'table_id') do |t|
      assert_equal({:id => 'table_id'}, t.attributes)
    end
  end
end
