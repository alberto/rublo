require 'stringio'
require_relative '../lib/path'

class PathTest < Test
  def gets_path_from_date_and_slug
    post = Post.new('title' => "The title", 'date' => '2011-05-20')
    path = Path.path_for post
    assert_equals("/2011/05/20/the-title/", path)
  end

  def gets_yaml_path_from_date_and_slug
    post = Post.new('title' => "The title", 'date' => '2011-05-20')
    path = Path.yaml_path_for post
    assert_equals("/posts/2011-05-20-the-title.yaml", path)
  end

end
