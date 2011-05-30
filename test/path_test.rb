require 'stringio'
require_relative 'post_factory'

class PathTest < Test
  def gets_path_from_date_and_slug
    post = PostFactory.create(:default)
    assert_equals("/2011/05/20/the-title/", post.uri)
  end

  def gets_yaml_path_from_date_and_slug
    post = PostFactory.create(:default)
    path = YamlPostGenerator.yaml_path_for post
    assert_equals("/posts/2011-05-20-the-title.yaml", path)
  end

end
