require_relative '../lib/post'
require_relative '../lib/post_repository'
require_relative 'test'

class PostRepositoryTest < Test
  def cannot_save_an_invalid_post
    repository = PostRepository.new([])
    post = Post.new({})
    begin
      repository.save post
      assert_fail
    rescue InvalidPostException
      assert_pass
    end
  end
end

class GeneratorMock
  attr_reader :post
 
  def generate post
    @post = post  
  end
end

class SavingAValidPostTest < Test
  def initialize
    @post = Post.new('title' => 'The title', 'date' => 'date')
    @generator = GeneratorMock.new
    @repository = PostRepository.new([@generator])
  end

  def a_valid_post_does_not_raise_exception
    begin
      @repository.save @post
      assert_pass
    rescue InvalidPostException
      assert_fail
    end
  end

  def a_valid_post_does_not_raise_exception
    begin
      @repository.save @post
      assert_pass
    rescue InvalidPostException
      assert_fail
    end
  end

  def repository_should_call_generators
    @repository.save @post
    assert_equals @post, @generator.post
  end
end
