require 'test_helper'

class InitializationTest < ActiveSupport::TestCase
  def builder
    TableView::TableBuilder.new(Post.scoped)
  end

  test "provides model class of relation" do
    assert_equal Post, builder.klass
  end
end
