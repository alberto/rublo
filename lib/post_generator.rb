class PostGenerator
  def initialize io, template, settings = {}
    @io = io
    @template = template
    @settings = settings
  end

  def generate post
    @io.write(parsed post)
  end

  def parsed post
    @template.parse @settings.merge(post.attributes)
  end
end
