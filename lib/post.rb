class RequiredFieldException < Exception
end

class Post
  include Comparable

  attr_reader :attributes
  alias_method :fields, :attributes

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

  def <=> other
    other.attributes['date'] <=> self.attributes['date']
  end

private
  def slug
    return nil if @attributes['title'].nil?
    @attributes['title'].downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end
end
