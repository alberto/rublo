Dir.entries(File.dirname(__FILE__)).each do |file|
  require_relative file if file =~ /_test\.rb/
end

require_relative 'test'
require_relative 'commandline_formatter'

class TestRunner
  def run(formatter = CommandLineFormatter.new)
    number_of_tests = 0
    failed_tests = 0
    test_classes = Test.descendants
    test_classes.each do |klass|
      formatter.test_fixture_start(klass)
      methods = klass.new.methods - Object.methods - Test.instance_methods
      number_of_tests += methods.count
      methods.each do |method|
        begin
          k = klass.new
          k.send(method)
          formatter.test_passed method.to_s
        rescue TestException => e
          formatter.test_failed method.to_s, e.message
          failed_tests +=1
        rescue Exception => e
          formatter.test_failed method.to_s, e.message, e        
          failed_tests +=1
        end
      end
      formatter.test_fixture_end(klass)
    end
    formatter.summary(number_of_tests, failed_tests)
  end
end

TestRunner.new.run
