module TableView
  module Renderers
    class BaseRenderer
      include ActionView::Helpers::TagHelper

      attr_reader :builder, :context

      def initialize builder, context
        @builder = builder
        @context = context
      end
    end
  end
end