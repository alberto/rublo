class Post
  def initialize attributes
    @attributes = attributes
  end
  
  def title
    @attributes["title"]
  end

  def body
    @attributes["body"]
  end
end
