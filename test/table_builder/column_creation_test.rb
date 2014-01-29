require 'test_helper'

class ColumnCreationTest < ActiveSupport::TestCase
  def builder
    @builder ||= TableView::TableBuilder.new(Post.all)
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
    column = builder.column(:title, :header_html => {:id => 'post_title'})
    assert_equal({:id => 'post_title'}, column.header_attributes)
  end

  test "allows to specify body attributes" do
    column = builder.column(:title, :body_html => {:style => 'color: red;'})
    assert_equal({:style => 'color: red;'}, column.body_attributes)
  end

  test "allows to specify sum option" do
    column = builder.column(:id, :sum => true)
    assert_equal true, column.sum?
  end

  test "doeas not set sum if not specified" do
    column = builder.column(:id)
    assert_equal false, column.sum?
  end

  test "builder sums column" do
    column = builder.column(:id, :sum => true)
    assert_equal Post.all.sum(:id), builder.sum(column)
  end

  test "builder sums column using lambdas" do
    column = builder.column(:id, :sum => lambda {|record| record.id * 2})
    assert_equal 2 * Post.all.sum(:id), builder.sum(column)
  end
end
