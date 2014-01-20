module TableView
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Installs TableView initializer"
      source_root File.expand_path("../templates", __FILE__)

      def create_initializer
        copy_file "initializer.rb", "config/initializers/table_view.rb"
      end
    end
  end
end