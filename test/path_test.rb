require 'stringio'
require_relative 'post_factory'

class PathTest < Test
  def initialize
    @post = PostFactory.create(:default)
  end
  
  def gets_path_from_date_and_slug
    assert_equals("/2011/05/20/the-title/", @post.uri)
  end

  def gets_yaml_path_from_date_and_slug
    path = YamlPostGenerator.yaml_path_for @post
    assert_equals("/posts/2011-05-20-the-title.yaml", path)
  end

end
