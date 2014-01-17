module TableView
  class Column
    attr_reader :name, :options, :block, :header_attributes, :body_attributes, :format

    def initialize name=nil, options={}, &block
      @name = name
      @options = options
      @block = block
      @header_attributes = @options.delete(:header_attributes) || {}
      @body_attributes = @options.delete(:body_attributes) || {}
      @format = @options.delete(:format)
    end

    def block_given?
      !!@block
    end
  end
end