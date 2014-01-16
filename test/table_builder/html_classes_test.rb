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
end
