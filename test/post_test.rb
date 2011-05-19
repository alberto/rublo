require_relative '../lib/post.rb'

class PostTest
  def can_set_post_title
    post = Post.new("title" => 'The title')    
    post.title == 'The title'
  end

  def can_set_post_body
    post = Post.new("body" => '<p>The body</p>')    
    post.body == '<p>The body</p>'
  end
end

tests = PostTest.new

puts tests.can_set_post_title
puts tests.can_set_post_body
