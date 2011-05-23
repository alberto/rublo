class PostGenerator
  def initialize io, template, settings = {}
    @io = io
    @template = template
    @settings = settings
  end

  def generate post
    parsed_template = @template.parse @settings.merge(post.attributes)
    @io.write(parsed_template)
  end
end
