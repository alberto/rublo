require_relative '../lib/post.rb'

class PostTest < Test
  def can_set_post_title
    post = Post.new("title" => 'The title')    
    assert_equals('The title', post.attributes["title"])
  end

  def can_set_post_body
    post = Post.new("body" => '<p>The body</p>')    
    assert_equals('<p>The body</p>', post.attributes["body"])
  end
end
