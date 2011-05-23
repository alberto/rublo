class Path
  def self.yaml_path_for post
    posts_dir = "/posts/"    
    post_filename = posts_dir + 
      post.attributes['date'].to_s + "-" + 
      post.attributes['slug'] + ".yaml"
  end
end
