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
