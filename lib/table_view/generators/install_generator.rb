module TableView
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Installs TableView initializer"
      source_root File.expand_path("../templates", __FILE__)
      class_option :bootstrap, :type => :boolean, desc: 'Set up initializer with Twitter Bootstrap defaults'

      def create_initializer
        if options[:bootstrap]
          copy_file "initializer_bootstrap.rb", "config/initializers/table_view.rb"
        else
          copy_file "initializer.rb", "config/initializers/table_view.rb"
        end
      end
    end
  end
end