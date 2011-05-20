require_relative '../lib/post'
require_relative '../lib/template_parser'
require_relative 'test'

class PostRepository
  def save post
    raise InvalidPostException.new unless post.valid?
  end
end

class InvalidPostException < Exception
  
end
class PostRepositoryTest < Test
  def cannot_save_an_invalid_post
    repository = PostRepository.new
    post = Post.new({})
    begin
      repository.save post
      assert_fail
    rescue InvalidPostException
      assert_pass
    end
  end

  def a_valid_post_does_not_raise_exception
    repository = PostRepository.new
    post = Post.new('title' => 'The title', 'date' => 'date')
    begin
      repository.save post
      assert_pass
    rescue InvalidPostException
      assert_fail
    end
  end
end
