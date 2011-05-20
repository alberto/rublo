class RequiredFieldException < Exception
end

class Post
  attr_reader :attributes

  def initialize attributes
    @attributes = attributes
    @attributes['slug'] ||= slug
  end

  def valid?
    %w{title date}.each do |field|
      return false if @attributes[field].nil? or @attributes[field].empty?
    end
    true
  end

private
  def slug
    return nil if @attributes['title'].nil?
    @attributes['title'].downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end
end
