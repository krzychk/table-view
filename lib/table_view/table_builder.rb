module TableView
  class TableBuilder
    attr_reader :relation, :klass, :columns, :classes, :link_attributes
    attr_accessor :link_cell_class, :no_records_label

    def initialize relation, attributes={}
      @relation = relation
      @klass = relation.klass
      @columns = []
      @row_classes = []
      @attributes = attributes
      @classes = TableView.default_table_classes.clone
      @classes += @attributes.delete(:class).split(" ") if @attributes[:class]
      @link_to = false
      @link_attributes = {}
      @link_cell_class = TableView.link_cell_class
      @no_records_label = I18n.t(TableView.i18n_no_records)
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
  end
end