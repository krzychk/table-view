require 'test_helper'

class TableViewTest < ActiveSupport::TestCase
  test "setup yields TestView" do
    TableView.setup do |config|
      assert_equal TableView, config
    end
  end
end
