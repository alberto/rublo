require_relative 'post_generator_test'
require_relative 'post_test'

test_classes = [PostTest, PostGeneratorTest]

test_classes.each do |klass|
  k = klass.new
  methods = k.methods - Object.methods - Test.instance_methods
  methods.each do |method|
    puts method.to_s
    k.send(method)
  end
end

