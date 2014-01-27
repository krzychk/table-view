require 'test_helper'

class HeaderRendererTest < ActionView::TestCase
  def builder
    @builder ||= TableView::TableBuilder.new(Post.all).tap do |t|
      t.column :title
      t.column :content
    end
  end

  def renderer
    @renderer ||= TableView::Renderers::HeaderRenderer.new(builder, self)
  end

  teardown {@builder = @renderer = nil}

  test "renders table header" do
    assert_dom_equal '<thead><tr><th>Title</th><th>Content</th></tr></thead>', renderer.to_html
  end
end
