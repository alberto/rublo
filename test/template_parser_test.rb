require_relative '../lib/post'
require_relative '../lib/template_parser'
require_relative 'test'

class TemplateParserTest < Test
  def generate_replaces_title_in_template
    post = Post.new("title" => "Foo")
    generator = TemplateParser.new ('<h2>##title##</h2>')
    generated_post = generator.parse post.attributes
    assert_equals("<h2>Foo</h2>", generated_post)
  end

  def generate_replaces_body_in_template
    post = Post.new("title" => "Foo", "body" => "<p>Bar</p>")
    generator = TemplateParser.new ('<h2>##title##</h2><article>##body##</article>')
    generated_post = generator.parse post.attributes
    assert_equals("<h2>Foo</h2><article><p>Bar</p></article>", generated_post)
  end

  def generate_ignores_unknown_attributes
    post = Post.new('title' => 'The title', "foo" => "Foo")
    generator = TemplateParser.new ('<h2>##title##</h2>')
    generated_post = generator.parse post.attributes
    assert_equals('<h2>The title</h2>', generated_post)
  end
end
