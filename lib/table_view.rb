require "table_view/table_builder"
require "table_view/column"
require "table_view/renderers"
require "table_view/helpers"


module TableView
  mattr_accessor :default_table_classes
  @@default_table_classes = []
  
  def self.setup
    yield self
  end
end