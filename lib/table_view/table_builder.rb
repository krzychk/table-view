module TableView
  class TableBuilder
    attr_reader :relation, :klass, :columns, :classes, :row_classes

    def initialize relation
      @relation = relation
      @klass = relation.klass
      @columns = []
      @classes = TableView.default_table_classes.clone
      @row_classes = []
    end

    def column name=nil, options={}, &block
      column = TableView::Column.new(name, options, &block)
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

    def row_classes= value
      if value.is_a? Array
        @row_classes = value
      else
        @row_classes = value.to_s.split(" ")
      end
    end
  end
end