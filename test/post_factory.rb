class PostFactory
    @@posts = {}

  def self.create post_symbol
    initialize if @@posts.empty?
    @@posts[post_symbol]
  end

private  
  def self.initialize
    @@posts[:default] = Post.new('title' => "The title", 'date' => '2011-05-20')    
    @@posts[:second] = Post.new('title' => "Second title", 'date' => '2011-05-22')    
  end

end
