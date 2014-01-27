require 'test_helper'

class BodyCellRendererTest < ActionView::TestCase
  fixtures :all
  
  def builder
    @builder ||= TableView::TableBuilder.new(Post.scoped)
  end

  def renderer column, record
    TableView::Renderers::BodyCellRenderer.new(builder, self, column, record)
  end

  teardown do 
    @builder = @renderer = nil
    TableView.setup do |config|
      config.i18n_boolean = nil
      config.link_cell_class = nil
      config.link_to false
    end
  end

  test "set contents using model.send method" do
    column = builder.column :title
    assert_dom_equal "<td>#{Post.first.send :title}</td>", renderer(column, Post.first).to_html
  end

  test "allows setting contents using block" do
    column = builder.column :title do |record|
      assert_kind_of Post, record
      record.title * 2
    end
    assert_dom_equal "<td>#{Post.first.title * 2}</td>", renderer(column, Post.first).to_html
  end

  test "attribute rendering" do
    column = builder.column :title, :body_attributes => {:style => 'color: red;'}
    assert_dom_equal "<td style=\"color: red;\">#{Post.first.send :title}</td>", renderer(column, Post.first).to_html
  end

  test "renders attributes defined by lambdas" do
    column = builder.column :title, :body_attributes => {:id => lambda {|post| "post_title_#{post.id}"}}
    assert_dom_equal "<td id=\"post_title_#{Post.first.id}\">#{Post.first.send :title}</td>", renderer(column, Post.first).to_html
  end

  test "uses specified format method" do
    column = builder.column :title, :format => :simple_format
    assert_dom_equal "<td><p>#{Post.first.send(:title)}</p></td>", renderer(column, Post.first).to_html
  end

  test "formats dates using I18n" do
    column = builder.column :created_at
    assert_dom_equal "<td>#{I18n.l(Post.first.created_at)}</td>", renderer(column, Post.first).to_html
  end

  test "formats booleans using I18n" do
    column = builder.column :is_active
    assert_dom_equal "<td>#{I18n.t(Post.first.is_active.to_s)}</td>", renderer(column, Post.first).to_html
  end

  test "default boolean i18n" do
    TableView.setup do |config|
      config.i18n_boolean = "booleans"
    end
    column = builder.column :is_active
    assert_dom_equal "<td>#{I18n.t("booleans.#{Post.first.is_active}")}</td>", renderer(column, Post.first).to_html
  end

  test "value translations" do
    column = builder.column :post_type, :translate => "post_types"
    assert_dom_equal "<td>#{I18n.t("post_types.#{Post.first.post_type}")}</td>", renderer(column, Post.first).to_html
  end

  test "collection rendering" do
    column = builder.column :tags
    assert_dom_equal "<td>#{Post.first.tags.map(&:to_s).join(", ")}</td>", renderer(column, Post.first).to_html
  end

  test "collection custom method rendering" do
    column = builder.column :tags, :label_method => :name
    assert_dom_equal "<td>#{Post.first.tags.map(&:name).join(", ")}</td>", renderer(column, Post.first).to_html
  end

  test "creating links" do
    builder.link_to :record
    column = builder.column :title
    assert_dom_equal "<td>#{link_to(Post.first.title, Post.first)}</td>", renderer(column, Post.first).to_html
  end

  test "creating complex links" do
    builder.link_to [:edit, :record]
    column = builder.column :title
    assert_dom_equal "<td>#{link_to(Post.first.title, edit_post_path(Post.first))}</td>", renderer(column, Post.first).to_html
  end

  test "link attributes" do
    builder.link_to :record, :remote => true
    column = builder.column :title
    assert_dom_equal "<td>#{link_to(Post.first.title, post_path(Post.first), :remote => true)}</td>", renderer(column, Post.first).to_html
  end

  test "default link_to setting" do
    TableView.setup do |config|
      config.link_to :record, :remote => true
    end
    column = builder.column :title
    assert_dom_equal "<td>#{link_to(Post.first.title, post_path(Post.first), :remote => true)}</td>", renderer(column, Post.first).to_html
  end

  test "doesn't create links on html safe values" do
    builder.link_to :record
    column = builder.column :content, :format => :simple_format
    assert_dom_equal "<td><p>#{Post.first.send(:content)}</p></td>", renderer(column, Post.first).to_html
  end

  test "link cell class" do
    builder.link_to :record
    builder.link_cell_class = "with-link"
    column = builder.column :title
    assert_dom_equal "<td class=\"with-link\">#{link_to(Post.first.title, post_path(Post.first))}</td>", renderer(column, Post.first).to_html
  end

  test "default link cell class" do
    TableView.setup do |config|
      config.link_cell_class = "cell-with-link"
    end
    builder.link_to :record
    column = builder.column :title
    assert_dom_equal "<td class=\"cell-with-link\">#{link_to(Post.first.title, post_path(Post.first))}</td>", renderer(column, Post.first).to_html
  end
end
