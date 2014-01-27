module TableView
  class Railtie < Rails::Railtie
    config.eager_load_namespaces << TableView
  end
end