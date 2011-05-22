require_relative 'path'

class YamlPostGenerator
  def generate post
    yaml_path = File.dirname(__FILE__) + "/.." + Path.yaml_path_for(post)
    FileUtils.mkdir_p(File.dirname(yaml_path))
		FileUtils.cp("post.yaml", yaml_path)
	end

  def self.find_all_files
    yaml_files = self.find_all_filenames.map { |file| YAML.load_file(File.dirname(__FILE__) + "/../posts/" + file)}
  end

  def self.find_all_filenames
    Dir.entries(File.dirname(__FILE__) + "/../posts").select { |file| File.extname(file) == ".yaml" }
  end
end
