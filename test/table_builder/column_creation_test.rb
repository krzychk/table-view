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
end
