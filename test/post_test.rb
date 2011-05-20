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

  def slug_does_not_contain_special_chars
    post = Post.new('title' => "The title 2.0")
    assert_equals('the-title-20', post.attributes["slug"])
  end

  def a_post_with_title_and_date_is_valid
    post = Post.new({'title' => 'Title', 'date' => '2011-01-11'})
    assert_equals(true, post.valid?)
  end

  def title_is_required
    post = Post.new({'date' => '2011-01-11'})
    assert_equals(false, post.valid?)
  end

  def date_is_required
    post = Post.new({'title' => '2011-01-11'})
    assert_equals(false, post.valid?)
  end

end
