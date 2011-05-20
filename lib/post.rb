class Post
  attr_reader :attributes

  def initialize attributes
    @attributes = attributes
    @attributes['slug'] ||= slug
  end

private
  def slug
    @attributes['title'].downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end
end
