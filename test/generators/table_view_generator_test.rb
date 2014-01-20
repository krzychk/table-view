require 'test_helper'

class TableViewGeneratorTest < Rails::Generators::TestCase
  tests TableView::Generators::InstallGenerator
  destination File.expand_path('../../tmp', __FILE__)
  setup :prepare_destination
  teardown { rm_rf(destination_root) }

  def config_options
    TableView.class_variables.map do |option|
      Regexp.new("config\\.#{option.to_s[2..-1]} = .+")
    end
  end

  test 'initializer' do
    run_generator
    assert_file 'config/initializers/table_view.rb', *config_options
  end
end