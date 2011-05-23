class YamlPostGenerator
  def generate post
    yaml_path = File.dirname(__FILE__) + "/.." + YamlPostGenerator.yaml_path_for(post)
    FileUtils.mkdir_p(File.dirname(yaml_path))
		FileUtils.cp("post.yaml", yaml_path)
	end

  def self.find_all_files
    yaml_files = self.find_all_filenames.map { |file| YAML.load_file(File.dirname(__FILE__) + "/../posts/" + file)}
  end

  def self.find_all_filenames
    Dir.entries(File.dirname(__FILE__) + "/../posts").select { |file| File.extname(file) == ".yaml" }
  end

  def self.yaml_path_for post
    posts_dir = "/posts/"    
    post_filename = posts_dir + 
    post.attributes['date'].to_s + "-" + 
    post.attributes['slug'] + ".yaml"
  end
end
