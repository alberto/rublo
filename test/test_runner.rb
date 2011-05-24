require_relative 'template_parser_test'
require_relative 'post_test'
require_relative 'post_repository_test'
require_relative 'post_generator_test'
require_relative 'path_test'
require_relative 'yaml_post_generator_test'
require_relative 'index_generator_test'

test_classes = [PostTest, TemplateParserTest, PostRepositoryTest, SavingAValidPostTest, PostGeneratorTest, PathTest, YamlPostGeneratorTest, IndexGeneratorTest]

test_classes.each do |klass|
  k = klass.new
  p klass
  methods = k.methods - Object.methods - Test.instance_methods
  methods.each do |method|
    begin
      puts method.to_s
      k.send(method)
    rescue Exception => e
      k.assert_fail
      puts e.message
      puts e.backtrace.inspect
    end
  puts
  end
end

