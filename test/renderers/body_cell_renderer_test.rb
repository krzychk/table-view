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
end
