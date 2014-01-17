require "table_view/table_builder"
require "table_view/column"
require "table_view/renderers"
require "table_view/helpers"


module TableView
  mattr_accessor :default_table_classes
  @@default_table_classes = []
  
  mattr_accessor :i18n_boolean
  @@i18n_boolean = nil

  def self.setup
    yield self
  end
end