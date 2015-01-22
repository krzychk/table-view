require 'test_helper'

class HeaderCellRendererTest < ActionView::TestCase
  fixtures :all
  
  def builder records=Post.all
    @builder ||= TableView::TableBuilder.new(records)
  end

  def renderer column
    TableView::Renderers::HeaderCellRenderer.new(builder, self, column)
  end

  setup {self.request = ActionController::TestRequest.new}

  teardown {@builder = @renderer = nil}

  test "sets label using human_attribute_name" do
    column = builder.column :title
    assert_dom_equal "<th>#{Post.human_attribute_name :title}</th>", renderer(column).to_html
  end

  test "sets label using human_attribute_name on associated class if source used" do
    column = builder(Tag.all).column :title, :source => :post
    assert_dom_equal "<th>#{Post.human_attribute_name :title}</th>", renderer(column).to_html
  end

  test "allows custom label" do
    column = builder.column :title, :label => 'Custom label'
    assert_dom_equal "<th>Custom label</th>", renderer(column).to_html
  end

  test "allows omitting name when block is given" do
    column = builder.column do
      "some contents"
    end
    assert_dom_equal "<th></th>", renderer(column).to_html
  end

  test "attribute rendering" do
    column = builder.column :title, :header_html => {:id => 'post_title'}
    assert_dom_equal "<th id=\"post_title\">#{Post.human_attribute_name :title}</th>", renderer(column).to_html
  end

  test "create sort link if option specified" do
    column = builder.column :title, :sortable => true
    assert_dom_equal "<th><a href=\"?sc=title&amp;sd=asc\">#{Post.human_attribute_name :title}</a></th>", renderer(column).to_html
  end

  test "create sort link with direction mark if params has sort keys" do
    column = builder.column :title, :sortable => true
    params[:sc] = 'title'
    params[:sd] = 'asc'
    assert_dom_equal "<th><a href=\"?sc=title&amp;sd=desc\">#{Post.human_attribute_name :title} &#9650;</a></th>", renderer(column).to_html
    params[:sd] = 'desc'
    assert_dom_equal "<th><a href=\"?sc=title&amp;sd=asc\">#{Post.human_attribute_name :title} &#9660;</a></th>", renderer(column).to_html
  end

  test "preserve query parameters in sort links" do
    column = builder.column :title, :sortable => true
    request.query_parameters["search"] = "phrase"
    assert_dom_equal "<th><a href=\"?sc=title&amp;sd=asc&amp;search=phrase\">#{Post.human_attribute_name :title}</a></th>", renderer(column).to_html
  end
end
