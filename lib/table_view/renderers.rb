module TableView
  module Renderers
    extend ActiveSupport::Autoload

    autoload :BaseRenderer
    autoload :BodyCellRenderer
    autoload :BodyRenderer
    autoload :HeaderCellRenderer
    autoload :HeaderRenderer
    autoload :TableRenderer
    autoload :FooterRenderer
  end
end