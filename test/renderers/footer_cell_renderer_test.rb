require 'test_helper'

class FooterCellRendererTest < ActionView::TestCase
  fixtures :all
  
  def builder
    @builder ||= TableView::TableBuilder.new(Post.all)
  end

  def renderer column
    TableView::Renderers::FooterCellRenderer.new(builder, self, column)
  end

  teardown do 
    @builder = @renderer = nil
  end

  test "renders empty column if no sum" do
    column = builder.column :title
    assert_dom_equal "<td></td>", renderer(column).to_html
  end

  test "renders sum if set to true" do
    column = builder.column :id, :sum => true
    assert_dom_equal "<td>#{Post.all.sum(:id)}</td>", renderer(column).to_html
  end

  test "displays sum using specified format method" do
    column = builder.column :id, :sum => true, :format => :simple_format
    assert_dom_equal "<td><p>#{Post.all.sum(:id)}</p></td>", renderer(column).to_html
  end
end
