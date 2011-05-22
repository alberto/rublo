class IndexGenerator
   def initialize io, posts_parser, index_parser
    @io = io
    @posts_parser = posts_parser
    @index_parser = index_parser
  end

  def generate post
    posts = PostRepository.find_all
    parsed_posts = parse_partial posts
    parsed_index = @index_parser.parse('posts' => parsed_posts)
    @io.write(parsed_index)
  end

  def parse_partial posts
    parsed = ""
    posts.each do |post|
      parsed << @posts_parser.parse(post.attributes)
    end
    parsed
  end
end

