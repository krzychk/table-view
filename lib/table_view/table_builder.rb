module TableView
  class TableBuilder
    attr_reader :relation, :klass, :columns, :classes

    def initialize relation
      @relation = relation
      @klass = relation.klass
      @columns = []
      @classes = []
    end

    def column name
      column = TableView::Column.new(name)
      columns.push(column)
      column
    end

    def records
      @records ||= @relation.all
    end

    def classes= value
      if value.is_a? Array
        @classes = value
      else
        @classes = value.to_s.split(" ")
      end
    end
  end
end