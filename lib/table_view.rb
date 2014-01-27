module TableView
  extend ActiveSupport::Autoload

  eager_autoload do
    autoload :TableBuilder
    autoload :Helpers
    autoload :Column
    autoload :Renderers
  end

  def self.eager_load!
    super
    TableView::Renderers.eager_load!
  end

  mattr_accessor :default_table_classes
  @@default_table_classes = []
  
  mattr_accessor :i18n_boolean
  @@i18n_boolean = nil

  mattr_accessor :i18n_no_records
  @@i18n_no_records = "no_records"

  mattr_accessor :link_cell_class
  @@link_cell_class = nil

  mattr_accessor :no_records_class
  @@no_records_class = nil

  def self.setup
    yield self
  end
end

require "table_view/railtie" if defined?(Rails)