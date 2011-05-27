class IndexGenerator
   def initialize io, posts_parser, index_parser, settings = {}
    @io = io
    @posts_parser = posts_parser
    @index_parser = index_parser
    @settings = settings
  end

  def generate post
    io = @io.new(Paths.index_path, 'w+')
    io.write(parsed_index)
  end

  def parsed_index
    @index_parser.parse(index_model)    
  end

  def index_model
    posts = PostRepository.find_all
    parsed_posts = parse_partial posts
    @settings.merge 'posts' => parsed_posts
  end

  def parse_partial posts
    parsed = ""
    posts.each do |post|
      parsed << @posts_parser.parse(post.attributes)
    end
    parsed
  end
end

