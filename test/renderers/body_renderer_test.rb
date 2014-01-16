require 'test_helper'

class BodyRendererTest < ActionView::TestCase
  fixtures :all
  
  def builder
    @builder ||= TableView::TableBuilder.new(Post.scoped).tap do |t|
      t.column :title
      t.column :content
    end
  end

  def renderer
    @renderer ||= TableView::Renderers::BodyRenderer.new(builder)
  end

  teardown {@builder = @renderer = nil}

  test "renders table body" do
    assert_dom_equal '<tbody>' +
        '<tr><td>First post</td><td>Contents of the first post</td></tr>' +
        '<tr><td>Second post</td><td>Contents of the second post</td></tr>' +
      '</tbody>', renderer.to_html
  end
end
