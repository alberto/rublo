require_relative 'template_parser_test'
require_relative 'post_test'
require_relative 'post_repository_test'
require_relative 'post_generator_test'
require_relative 'path_test'

test_classes = [PostTest, TemplateParserTest, PostRepositoryTest, SavingAValidPostTest, PostGeneratorTest, PathTest]

test_classes.each do |klass|
  k = klass.new
  methods = k.methods - Object.methods - Test.instance_methods
  methods.each do |method|
    k.send(method)
    puts method.to_s
    puts 
  end
end

