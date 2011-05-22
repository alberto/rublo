class InvalidPostException < Exception  
end

class PostRepository
  def initialize generators 
    @generators = generators
  end

  def save post
    raise InvalidPostException.new unless post.valid?
    @generators.each do |generator|
      generator.generate post
    end
  end

  def self.find_all
    post = Post.new('title' => 'The title', 'date' => '2011-05-1', 'body' => 'foo')
    newer_post = Post.new('title' => 'Second title', 'date' => '2011-05-2', 'body' => 'bar')
    [newer_post, post]    
  end
end
