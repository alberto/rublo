class Paths
  def self.post_path post
    post_dirpath(post) + "index.html"
  end

  def self.public_path
    File.dirname(__FILE__) + "/../public"
  end

  def self.post_dirpath post
    public_path + post.uri    
  end

  def self.index_path
    public_path + "/index.html"
  end
end
