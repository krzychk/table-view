module TableView
  class TableBuilder
    attr_reader :relation, :klass, :columns, :classes, :link_attributes, :default_order_column, :default_order_direction
    attr_accessor :link_cell_class, :no_records_label, :no_records_class

    def initialize relation, attributes={}
      @relation = relation
      @klass = relation.klass
      @columns = []
      @row_classes = []
      @attributes = attributes
      @classes = TableView.default_table_classes.clone
      @classes += @attributes.delete(:class).split(" ") if @attributes[:class]
      @link_attributes = {}
      @link_cell_class = TableView.link_cell_class
      @no_records_label = I18n.t(TableView.i18n_no_records)
      @no_records_class = TableView.no_records_class
      link_to *TableView.link_to
    end

    def column name=nil, options={}, &block
      column = TableView::Column.new(name, options, &block)
      columns.push(column)
      column
    end

    def records sort_by=nil, sort_direction=nil
      @records ||= sorted_relation(sort_by, sort_direction).load
    end

    def classes= value
      if value.is_a? Array
        @classes = value
      else
        @classes = value.to_s.split(" ")
      end
    end

    def row_classes= value
      if value.is_a?(Array)
        @row_classes = value
      else
        @row_classes = value.to_s.split(" ")
      end
    end

    def row_classes &block
      if block_given?
        @row_classes = block
      else
        @row_classes
      end
    end

    def attributes
      attributes = @attributes.clone
      attributes[:class] = classes.join(' ') if classes.any?
      attributes
    end

    def link_to value=nil, link_attributes={}
      if value === nil
        @link_to
      else
        @link_to = value
        @link_attributes = link_attributes
      end
    end

    def has_sums?
      columns.any?(&:sum?)
    end

    def sum column
      if column.sum_as_proc?
        records.map(&column.sum).sum
      else
        records.map(&column.name).sum
      end
    end

    def default_order column, direction
      @default_order_column = column
      @default_order_direction = direction
    end

    private

    def sorted_relation sort_by, sort_direction
      column = column_by_name(sort_by) if sort_by
      if column && column.sortable
        if column.sort_by_lambda?
          column.sortable.call(@relation, sort_direction)
        elsif column.sort_by_scope?
          @relation.send(column.sortable, sort_direction)
        else
          @relation.order(sort_by => sort_direction)
        end
      elsif default_order_column && default_order_direction
        @relation.order(default_order_column => default_order_direction)
      else
        @relation
      end
    end

    def column_by_name name
      name = name.to_s
      columns.each do |column|
        return column if column.name.to_s == name
      end
      return nil
    end
  end
end