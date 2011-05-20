require_relative '../lib/post.rb'

class PostTest < Test
  def can_set_post_title
    post = Post.new('title' => 'The title')    
    assert_equals('The title', post.attributes["title"])
  end

  def can_set_post_body
    post = Post.new('title' => 'title', 'body' => '<p>The body</p>')    
    assert_equals('<p>The body</p>', post.attributes["body"])
  end

  def creates_slug_from_title_if_slug_is_not_present
    post = Post.new('title' => 'The title')
    assert_equals('the-title', post.attributes["slug"])

    post = Post.new('title' => 'Another title')
    assert_equals('another-title', post.attributes["slug"])

  end

  def uses_custom_slug_if_defined
    post = Post.new('title' => 'The title', 'slug' => 'a-custom-slug')
    assert_equals('a-custom-slug', post.attributes["slug"])
  end
end
