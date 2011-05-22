class TemplateParser
  def initialize template
    @template = template
  end

  def parse fields
    parsed_file = @template.clone
    fields.each_pair do |key, value|
      parsed_file.gsub!("###{key}##", value)
    end
    parsed_file
  end
end
