require 'test_helper'

class InitializationTest < ActiveSupport::TestCase
  def builder attributes={}
    TableView::TableBuilder.new(Post.all, attributes)
  end

  test "provides model class of relation" do
    assert_equal Post, builder.klass
  end

  test "provides all models of given relation" do
    assert_equal Post.all.load, builder.records
  end

  test "provides given attributes" do
    assert_equal({:id => 'table_id'}, builder(:id => 'table_id').attributes)
  end

  test "performs sort if params specified" do
    assert_equal Post.order(:id => :desc), builder.records(:id, :desc)
  end
end
