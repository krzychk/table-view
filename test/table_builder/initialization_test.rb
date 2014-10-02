require 'test_helper'

class InitializationTest < ActiveSupport::TestCase
  def builder attributes={}
    @builder ||= TableView::TableBuilder.new(Post.all, attributes)
  end

  teardown {@builder = nil}

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
    builder.column :id, :sortable => true
    assert_equal Post.order(:id => :desc), builder.records(:id, :desc)
  end

  test "performs sort by lambda" do
    builder.column :random_name, :sortable => lambda {|query, direction| query.order(:id => direction)}
    assert_equal Post.order(:id => :desc), builder.records(:random_name, :desc)
  end

  test "performs sort by scope" do
    builder.column :random_name, :sortable => :sort_by_id
    assert_equal Post.order(:id => :desc), builder.records(:random_name, :desc)
  end

  test "performs default sorting if no sort on column" do
    builder.column :id
    builder.default_order :id, :desc
    assert_equal Post.order(:id => :desc), builder.records
  end

  test "doesn't perform sorting if sort on column definded" do
    builder.column :id, :sortable => true
    builder.default_order :id, :desc
    assert_equal Post.order(:id => :asc), builder.records(:id, :asc)
  end
end
