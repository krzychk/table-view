require 'test_helper'

class InitializationTest < ActiveSupport::TestCase
  def builder attributes={}
    TableView::TableBuilder.new(Post.scoped, attributes)
  end

  test "provides model class of relation" do
    assert_equal Post, builder.klass
  end

  test "provides all models of given relation" do
    assert_kind_of Array, builder.records
  end

  test "provides given attributes" do
    assert_equal({:id => 'table_id'}, builder(:id => 'table_id').attributes)
  end
end
