require 'test_helper'

class BodyRendererTest < ActionView::TestCase
  fixtures :all
  
  def builder posts=Post.scoped
    @builder ||= TableView::TableBuilder.new(posts).tap do |t|
      t.column :title
      t.column :content
    end
  end

  def renderer
    @renderer ||= TableView::Renderers::BodyRenderer.new(builder, self)
  end

  teardown do 
    @builder = @renderer = nil
    TableView.setup do |config|
      config.i18n_no_records = "no_records"
    end
  end

  test "renders table body" do
    assert_dom_equal '<tbody>' +
        '<tr><td>First post</td><td>Contents of the first post</td></tr>' +
        '<tr><td>Second post</td><td>Contents of the second post</td></tr>' +
      '</tbody>', renderer.to_html
  end

  test "row html classes" do
    builder.row_classes = "row"
    assert_dom_equal '<tbody>' +
        '<tr class="row"><td>First post</td><td>Contents of the first post</td></tr>' +
        '<tr class="row"><td>Second post</td><td>Contents of the second post</td></tr>' +
      '</tbody>', renderer.to_html
  end

  test "row html classes using block" do
    builder.row_classes {|record| "row-#{record.id}"}
    assert_dom_equal '<tbody>' +
        '<tr class="row-' + Post.all[0].id.to_s + '"><td>First post</td><td>Contents of the first post</td></tr>' +
        '<tr class="row-' + Post.all[1].id.to_s + '"><td>Second post</td><td>Contents of the second post</td></tr>' +
      '</tbody>', renderer.to_html
  end

  test "no records row" do
    builder Post.where('1 = 0')
    assert_dom_equal '<tbody>' +
        '<tr><td colspan="2">' + I18n.t('no_records') + '</td></tr>' +
      '</tbody>', renderer.to_html
  end

  test "custom label for no records row" do
    builder(Post.where('1 = 0')).no_records_label = "No records"
    assert_dom_equal '<tbody>' +
        '<tr><td colspan="2">No records</td></tr>' +
      '</tbody>', renderer.to_html
  end

  test "default translation for no records row" do
    TableView.setup do |config|
      config.i18n_no_records = "nothing_to_show"
    end
    builder Post.where('1 = 0')
    assert_dom_equal '<tbody>' +
        '<tr><td colspan="2">' + I18n.t('nothing_to_show') + '</td></tr>' +
      '</tbody>', renderer.to_html
  end
end
