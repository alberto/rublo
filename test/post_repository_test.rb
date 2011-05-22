require_relative '../lib/post'
require_relative '../lib/post_repository'
require_relative '../lib/yaml_post_generator'
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

  def can_retrieve_published_posts_from_yaml_using_yaml_post_generator
    new_find_all = <<EOM
      def self.find_all_files
      ['title' => "The title", 'date' => '2011-05-22']
      end
EOM
    with_replaced_method(YamlPostGenerator, 'find_all_files', new_find_all) do
      posts = PostRepository.find_all
      assert_equals("The title", posts[0].attributes['title'])
      assert_equals("2011-05-22", posts[0].attributes['date'])
    end
  end

  def published_posts_are_ordered_by_descending_date
    new_find_all = <<EOM
      def self.find_all_files
      [{'title' => "The title", 'date' => '2011-05-12'}, 
      {'title' => "Newer post", 'date' => '2011-05-22'}, ]
      end
EOM
    with_replaced_method(YamlPostGenerator, 'find_all_files', new_find_all) do
      posts = PostRepository.find_all
      assert_equals("2011-05-22", posts[0].attributes['date'])
      assert_equals("2011-05-12", posts[1].attributes['date'])
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
