require 'test_helper'

class FooterRendererTest < ActionView::TestCase
  fixtures :all
  
  def builder posts=Post.all
    @builder ||= TableView::TableBuilder.new(posts).tap do |t|
      t.column :title
      t.column :content
    end
  end

  def renderer
    @renderer ||= TableView::Renderers::FooterRenderer.new(builder, self)
  end

  teardown do 
    @builder = @renderer = nil
  end

  test "renders table foot" do
    assert_dom_equal '<tfoot>' +
        '<tr><td></td><td></td></tr>' +
      '</tfoot>', renderer.to_html
  end

  test "renders sums" do
    builder.column :id, :sum => true
    assert_dom_equal '<tfoot>' +
        '<tr><td></td><td></td><td>' + Post.all.sum(:id).to_s + '</td></tr>' +
      '</tfoot>', renderer.to_html
  end
end
