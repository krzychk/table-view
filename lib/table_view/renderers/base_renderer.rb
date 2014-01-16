module TableView
  module Renderers
    class BaseRenderer
      include ActionView::Helpers::TagHelper

      attr_reader :builder

      def initialize builder
        @builder = builder
      end
    end
  end
end