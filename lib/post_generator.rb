class PostGenerator
  def initialize io, template
    @io = io
    @template = template
  end

  def generate post
    parsed_template = @template.parse post.attributes
    @io.write(parsed_template)
  end
end
