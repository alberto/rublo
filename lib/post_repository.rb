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
end