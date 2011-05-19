require_relative '../lib/post'

class PostGenerator
  def initialize template
    @template = template
  end
  def generate post
    @template.gsub!("##title##", post.attributes["title"])
  end
end

class PostGeneratorTest
  def generate_replaces_title_in_template
    post = Post.new("title" => "Foo")
    generator = PostGenerator.new ('<h2>##title##</h2>')
    generated_post = generator.generate post
    generated_post == "<h2>Foo</h2>"
  end

end

tests = PostGeneratorTest.new
p tests.generate_replaces_title_in_template

