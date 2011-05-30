require_relative 'paths'

class PostGenerator
  def initialize io, template, settings = {}
    @io = io
    @template = template
    @settings = settings
  end

  def generate post
    io = @io.new(Paths.post_path(post), 'w+')
    io.write(parsed post)
  end

  def parsed post
    @template.parse @settings.merge(post.fields)
  end
end
