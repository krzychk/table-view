module TableView
  class Column
    attr_reader :name, :options, :block

    def initialize name, options={}, &block
      @name = name
      @options = options
      @block = block
    end

    def block_given?
      !!@block
    end
  end
end