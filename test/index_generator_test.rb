require_relative '../lib/index_generator'
require_relative '../lib/post_repository'
require_relative '../lib/template_parser'

class PostRepository
  def self.find_all
    post = Post.new('title' => 'The title', 'date' => '2011-05-1')
    newer_post = Post.new('title' => 'Second title', 'date' => '2011-05-2')
    [newer_post, post]    
  end
end

class IndexGeneratorStub < IndexGenerator
  def parse_partial posts
    "<p>parsed posts</p>"
  end
end

class IndexGeneratorTest < Test
  def can_generate_partial_html_from_posts
    io = StringIO.new("")
    posts_template = "<p>##title## - ##date##</p>"
    posts_parser = TemplateParser.new posts_template
    index_generator = IndexGenerator.new(io, posts_parser, nil)
    
    assert_equals("<p>Second title - 2011-05-2</p><p>The title - 2011-05-1</p>", index_generator.parse_partial(PostRepository.find_all))
  end

  def can_generate_index_page
    io = StringIO.new("")
    index_template = "<div>##posts##</div>"
    parser = TemplateParser.new index_template
    index_generator = IndexGeneratorStub.new(io, nil, parser)
    index_generator.generate nil
    assert_equals("<div><p>parsed posts</p></div>", io.string)
  end
end
