module TableView
  class TableBuilder
    attr_accessor :relation, :klass, :columns

    def initialize relation
      @relation = relation
      @klass = relation.klass
      @columns = []
    end

    def column name
      column = TableView::Column.new(name)
      columns.push(column)
      column
    end
  end
end