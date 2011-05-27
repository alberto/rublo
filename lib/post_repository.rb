require 'yaml'
class InvalidPostException < Exception  
end

class PostRepository
  def initialize generators 
    @generators = generators
  end

  def save post
    raise InvalidPostException.new unless post.valid?
    run_generators_for post
  end

  def run_generators_for post
    @generators.each do |generator|
      generator.generate post
    end
  end

  def self.find_all
    yaml_files = YamlPostGenerator.find_all_files
    posts_from(yaml_files)
  end

  def self.posts_from yaml_files
    posts = []
    yaml_files.each do |yaml|
      posts << Post.new(yaml)
    end
    posts.sort
  end
end
