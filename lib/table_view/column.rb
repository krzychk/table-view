module TableView
  class Column
    attr_reader :name, :options, :block, :header_attributes, :body_attributes, :footer_attributes, :format, :translate, :label_method, :sum, :sortable, :source

    def initialize name=nil, options={}, &block
      @name = name
      @options = options
      @block = block
      @header_attributes = @options.delete(:header_html) || {}
      @body_attributes = @options.delete(:body_html) || {}
      @footer_attributes = @options.delete(:footer_html) || {}
      @format = @options.delete(:format)
      @translate = @options.delete(:translate)
      @label_method = @options.delete(:label_method) || :to_s
      @sortable = @options.delete(:sortable) || false
      @sum = @options.delete(:sum)
      @source = @options.delete(:source)
    end

    def block_given?
      !!@block
    end

    def sum?
      !!sum
    end

    def sort_by_lambda?
      sortable.is_a?(Proc)
    end

    def sort_by_scope?
      sortable.is_a?(Symbol)
    end

    def sum_as_proc?
      sum.is_a? Proc
    end
  end
end
