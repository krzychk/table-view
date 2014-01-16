require 'test_helper'

class HtmlClassesTest < ActiveSupport::TestCase
  def builder
    @builder ||= TableView::TableBuilder.new(Post.scoped)
  end

  teardown {@builder = nil}

  test "classes method returns array of table classes" do
    assert_kind_of Array, builder.classes
  end

  test "allow classes appending" do
    builder.classes << "my-table-class"
    assert_includes builder.classes, "my-table-class"
  end

  test "allow classes overriding" do
    builder.classes = ["my-table-class", "other-class"]
    assert_includes builder.classes, "my-table-class"
    assert_includes builder.classes, "other-class"
  end

  test "allow classes overriding with string given" do
    builder.classes = "my-table-class other-class"
    assert_kind_of Array, builder.classes
    assert_includes builder.classes, "my-table-class"
    assert_includes builder.classes, "other-class"
  end

  test "row_classes method returns array of row classes" do
    assert_kind_of Array, builder.row_classes
  end

  test "allow row classes appending" do
    builder.row_classes << "my-row-class"
    assert_includes builder.row_classes, "my-row-class"
  end

  test "allow row classes overriding" do
    builder.row_classes = ["my-row-class", "other-class"]
    assert_includes builder.row_classes, "my-row-class"
    assert_includes builder.row_classes, "other-class"
  end

  test "allow row classes overriding with string given" do
    builder.row_classes = "my-row-class other-class"
    assert_kind_of Array, builder.row_classes
    assert_includes builder.row_classes, "my-row-class"
    assert_includes builder.row_classes, "other-class"
  end

  test "allow row classes overriding using block" do
    builder.row_classes do |record|
      "class"
    end
    assert_kind_of Proc, builder.row_classes
  end
end
