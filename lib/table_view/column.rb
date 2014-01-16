module TableView
  class Column
    attr_reader :name

    def initialize name
      @name = name
    end
  end
end