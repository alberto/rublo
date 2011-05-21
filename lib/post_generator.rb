class PostGenerator
  def initialize io, template
    @io = io
    @template = template
  end

  def self.relative_dir_path_for post
    slug = post.attributes['slug']
    date = post.attributes['date'].gsub!('-', '/')
    path = "/#{date}/#{slug}/"
  end

  def generate post
    parsed_template = @template.parse post.attributes
    @io.write(parsed_template)
  end
end
