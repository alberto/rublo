class Path
  def self.path_for post
    slug = post.attributes['slug']
    date = post.attributes['date'].gsub('-', '/')
    path = "/#{date}/#{slug}/"
  end

  def self.yaml_path_for post
    posts_dir = "/posts/"    
    post_filename = posts_dir + 
      post.attributes['date'].to_s + "-" + 
      post.attributes['slug'] + ".yaml"
  end
end
