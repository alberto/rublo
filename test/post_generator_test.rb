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
