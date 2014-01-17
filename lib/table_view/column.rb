module TableView
  class Column
    attr_reader :name, :options, :block, :header_attributes, :body_attributes

    def initialize name=nil, options={}, &block
      @name = name
      @options = options
      @block = block
      @header_attributes = @options.delete(:header_attributes) || {}
      @body_attributes = @options.delete(:body_attributes) || {}
    end

    def block_given?
      !!@block
    end
  end
end