module TableView
  class TableBuilder
    attr_accessor :relation
    attr_accessor :klass

    def initialize relation
      @relation = relation
      @klass = relation.klass
    end
  end
end