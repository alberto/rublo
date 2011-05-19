require_relative '../lib/post'

class PostGenerator
  def initialize template
    @template = template
  end
  def generate post
    post.attributes.each_pair do |key, value|
      @template.gsub!("###{key}##", value)
    end
    @template
  end
end

class PostGeneratorTest
  def generate_replaces_title_in_template
    post = Post.new("title" => "Foo")
    generator = PostGenerator.new ('<h2>##title##</h2>')
    generated_post = generator.generate post
    generated_post == "<h2>Foo</h2>"
  end

  def generate_replaces_body_in_template
    post = Post.new("title" => "Foo", "body" => "<p>Bar</p>")
    generator = PostGenerator.new ('<h2>##title##</h2><article>##body##</article>')
    generated_post = generator.generate post
    generated_post == "<h2>Foo</h2><article><p>Bar</p></article>"
  end
end

tests = PostGeneratorTest.new
p tests.generate_replaces_title_in_template
p tests.generate_replaces_body_in_template
