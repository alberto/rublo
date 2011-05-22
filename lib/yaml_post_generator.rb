require_relative 'path'

class YamlPostGenerator
  def generate post
    yaml_path = File.dirname(__FILE__) + "/.." + Path.yaml_path_for(post)
    FileUtils.mkdir_p(File.dirname(yaml_path))
		FileUtils.cp("post.yaml", yaml_path)
	end
end
