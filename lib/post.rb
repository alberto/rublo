class RequiredFieldException < Exception
end

class Post
  attr_reader :attributes

  def initialize attributes
    @attributes = attributes
    @attributes['slug'] ||= slug
    @attributes['date'] ||= Date.today.to_s
    @attributes['uri'] = uri
  end

  def valid?
    %w{title date}.each do |field|
      return false if @attributes[field].nil? or @attributes[field].empty?
    end
    true
  end

  def ==(another_post)
    self.attributes == another_post.attributes
  end

  def uri
    slug = @attributes['slug']
    date = @attributes['date'].gsub('-', '/')
    path = "/#{date}/#{slug}/"
  end

private
  def slug
    return nil if @attributes['title'].nil?
    @attributes['title'].downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end
end
