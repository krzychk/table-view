require 'test_helper'

class ColumnCreationTest < ActiveSupport::TestCase
  def builder
    @builder ||= TableView::TableBuilder.new(Post.scoped)
  end

  teardown {@builder = nil}

  test "returns TableView::Column" do
    assert_kind_of TableView::Column, builder.column(:title)
  end

  test "returns column with given name" do
    assert_equal :title, builder.column(:title).name
  end

  test "appends column" do
    column = builder.column(:title)
    assert_includes builder.columns, column
  end

  test "allows to specify header attributes" do
    column = builder.column(:title, :header_attributes => {:id => 'post_title'})
    assert_equal({:id => 'post_title'}, column.header_attributes)
  end

  test "allows to specify body attributes" do
    column = builder.column(:title, :body_attributes => {:style => 'color: red;'})
    assert_equal({:style => 'color: red;'}, column.body_attributes)
  end
end
