require_relative 'template_parser_test'
require_relative 'post_test'
require_relative 'post_repository_test'
require_relative 'post_generator_test'
require_relative 'path_test'
require_relative 'yaml_post_generator_test'
require_relative 'index_generator_test'

test_classes = [PostTest, TemplateParserTest, PostRepositoryTest, SavingAValidPostTest, PostGeneratorTest, PathTest, YamlPostGeneratorTest, IndexGeneratorTest]

number_of_tests = 0
failed_tests = 0
test_classes.each do |klass|
  p klass
  methods = klass.new.methods - Object.methods - Test.instance_methods
  number_of_tests += methods.count
  methods.each do |method|
    begin
      k = klass.new
      puts method.to_s
      k.send(method)
    rescue Exception => e
      k.assert_fail
      puts e.message
      puts e.backtrace.inspect
    ensure
      failed_tests +=1 if k.failed?
    end
  puts
  end
end
puts "#{number_of_tests} tests run, #{failed_tests} failed"
