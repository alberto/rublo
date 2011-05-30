class RequiredFieldException < Exception
end

class Post
  include Comparable

  attr_reader :fields

  def initialize fields
    @fields = fields
    @fields['slug'] ||= slug
    @fields['date'] ||= Date.today.to_s
    @fields['uri'] = uri
  end

  def valid?
    %w{title date}.each do |field|
      return false if @fields[field].nil? or @fields[field].empty?
    end
    true
  end

  def ==(another_post)
    self.fields == another_post.fields
  end

  def uri
    slug = @fields['slug']
    date = @fields['date'].gsub('-', '/')
    path = "/#{date}/#{slug}/"
  end

  def <=> other
    other.fields['date'] <=> self.fields['date']
  end

private
  def slug
    return nil if @fields['title'].nil?
    @fields['title'].downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end
end
