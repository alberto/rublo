require 'stringio'
require_relative '../lib/post_generator'

class FakeTemplate
  def parse post
    @parse_was_called = true
    "result"
  end
  def parse_was_called?
    @parse_was_called || false
  end
end

class PostGeneratorTest < Test
  def gets_path_from_date_and_slug
    generator = PostGenerator.new(nil, nil)
    post = Post.new('title' => "The title", 'date' => '2011-05-20')
    path = generator.relative_dir_path_for post
    assert_equals("/2011/05/20/the-title/", path)
  end

  def calls_parse_on_template
    post = Post.new('title' => "The title", 'date' => '2011-05-20')
    io = StringIO.new("")
    template = FakeTemplate.new
    generator = PostGenerator.new(io, template)
    generator.generate post
    assert_equals(true, template.parse_was_called?)    
  end

  def writes_result_to_io
    post = Post.new('title' => "The title", 'date' => '2011-05-20')
    io = StringIO.new("")  
    generator = PostGenerator.new(io, FakeTemplate.new)
    generator.generate post
    assert_equals("result", io.string)
  end
end
