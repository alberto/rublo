require_relative '../lib/index_generator'
require_relative '../lib/post_repository'
require_relative '../lib/template_parser'

class IndexGeneratorStub < IndexGenerator
  def parse_partial posts
    "<p>parsed posts</p>"
  end
end

class IndexGeneratorTest < Test
  def can_generate_partial_html_from_posts
    io = StringIO
    posts_template = "<p>##title## - ##date##</p>"
    posts_parser = TemplateParser.new posts_template
    index_generator = IndexGenerator.new(io, posts_parser, nil)
    post = Post.new('title' => 'The title', 'date' => '2011-05-1')
    newer_post = Post.new('title' => 'Second title', 'date' => '2011-05-2')
            
    assert_equals("<p>Second title - 2011-05-2</p><p>The title - 2011-05-1</p>", index_generator.parse_partial([newer_post, post]))
  end

  def can_generate_index_page
    io = StringIO
    index_template = "<div>##posts##</div>"
    parser = TemplateParser.new index_template
    index_generator = IndexGeneratorStub.new(io, nil, parser)
    parsed = index_generator.parsed_index
    assert_equals("<div><p>parsed posts</p></div>", parsed)
  end
end
