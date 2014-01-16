module TableView
  class Column
    attr_reader :name, :options

    def initialize name, options={}
      @name = name
      @options = options
    end
  end
end