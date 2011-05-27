require_relative "../lib/post_generator"
require_relative "../lib/yaml_post_generator"
require_relative "../lib/post_repository"
require_relative "../lib/template_parser"
require_relative "../lib/index_generator"
require_relative "../lib/paths"

class Factory
  def self.create_post_repository   
    yaml_post_generator = YamlPostGenerator.new
    generators = [post_generator, yaml_post_generator, index_generator]
    PostRepository.new(generators)    
  end

  def self.create_post
    yaml = YAML.load_file("post.yaml")
    Post.new(yaml)
  end

private
  def self.post_generator
    template = File.read('post.rhtml')
    template_parser = TemplateParser.new(template)
    PostGenerator.new(File, template_parser, settings)
  end

  def self.index_generator
    posts_parser = TemplateParser.new(File.read("posts.rhtml"))
    index_parser = TemplateParser.new(File.read("index.rhtml"))
    IndexGenerator.new(File, posts_parser, index_parser, settings)    
  end

  def self.settings
    YAML.load_file("settings.yaml")
  end
end
