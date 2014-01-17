require 'test_helper'

class BodyCellRendererTest < ActionView::TestCase
  fixtures :all
  
  def builder
    @builder ||= TableView::TableBuilder.new(Post.scoped)
  end

  def renderer column, record
    TableView::Renderers::BodyCellRenderer.new(builder, column, record)
  end

  teardown {@builder = @renderer = nil}

  test "set contents using model.send method" do
    column = builder.column :title
    assert_dom_equal "<td>#{Post.first.send :title}</td>", renderer(column, Post.first).to_html
  end

  test "allows setting contents using block" do
    column = builder.column :title do |record|
      assert_kind_of Post, record
      record.title * 2
    end
    assert_dom_equal "<td>#{Post.first.title * 2}</td>", renderer(column, Post.first).to_html
  end

  test "attribute rendering" do
    column = builder.column :title, :body_attributes => {:style => 'color: red;'}
    assert_dom_equal "<td style=\"color: red;\">#{Post.first.send :title}</td>", renderer(column, Post.first).to_html
  end
end
