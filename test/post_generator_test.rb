require 'stringio'
require_relative '../lib/post_generator'
require_relative 'post_factory'

class FakeTemplate
  def parse post
    @parse_was_called = true
    "result"
  end
  def parse_was_called?
    @parse_was_called || false
  end
end

class FakeIO
  def write string
      @@write_was_called = true
  end

  def self.write_was_called?
    @@write_was_called || false
  end
end

class PostGeneratorTest < Test
  def calls_parse_on_template
    post = PostFactory.create(:default)
    io = StringIO
    template = FakeTemplate.new
    generator = PostGenerator.new(io, template)
    generator.generate post
    assert_true template.parse_was_called?
  end

  def writes_result_to_io
    post = PostFactory.create(:default)
    io = FakeIO  
    generator = PostGenerator.new(io, FakeTemplate.new)
    generator.generate post
    assert_true(io.write_was_called?)
  end
end
