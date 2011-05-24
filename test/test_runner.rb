require_relative 'template_parser_test'
require_relative 'post_test'
require_relative 'post_repository_test'
require_relative 'post_generator_test'
require_relative 'path_test'
require_relative 'yaml_post_generator_test'
require_relative 'index_generator_test'

test_classes = [PostTest, TemplateParserTest, PostRepositoryTest, SavingAValidPostTest, PostGeneratorTest, PathTest, YamlPostGeneratorTest, IndexGeneratorTest]

def humanize text
  text.gsub!('_', ' ')
end

def colorize(text, color_code)
  puts "#{color_code}  #{humanize text}\e[0m"
end

def red text
  colorize(text, "\e[31m")
end

def green text
  colorize(text, "\e[32m")
end

number_of_tests = 0
failed_tests = 0
test_classes.each do |klass|
  p klass
  methods = klass.new.methods - Object.methods - Test.instance_methods
  number_of_tests += methods.count
  methods.each do |method|
    begin
      k = klass.new
      k.send(method)
      green method.to_s
    rescue TestException => e      
      failed_tests +=1
      red method.to_s
      red e.message
    rescue Exception => e
      failed_tests +=1
      puts e.message
      puts e.backtrace.inspect
    end
  end
  puts
end
puts "#{number_of_tests} tests run, #{failed_tests} failed"

