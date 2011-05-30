Dir.entries(File.dirname(__FILE__)).each do |file|
  require_relative file if file =~ /_test\.rb/
end

require_relative 'test'
require_relative 'commandline_formatter'

class TestRunner
  def run(formatter = CommandLineFormatter.new)
    @failed_tests = 0
    @formatter = formatter
    test_fixtures.each do |fixture|
      run_tests_in(fixture)
    end
    @formatter.summary(number_of_tests, @failed_tests)
  end  

  def test_fixtures
    Test.descendants
  end
  
  def run_tests_in fixture
    @formatter.fixture_start(fixture)
    tests = tests_in fixture
    tests.each do |test|
      run_test(fixture, test)
    end
    @formatter.fixture_end(fixture)
  end
  
  def number_of_tests
    total = 0
    test_fixtures.each do |test_fixture|
      total += tests_in(test_fixture).count
    end
    total
  end
  
  def tests_in fixture
    fixture.new.methods - Object.methods - Test.instance_methods
  end
  
  def run_test (klass, test)
    begin
      k = klass.new
      k.send(test)
      @formatter.test_passed test.to_s
    rescue TestException => e
      @formatter.test_failed test.to_s, e.message
      @failed_tests += 1
    rescue Exception => e
      @formatter.test_failed(test.to_s, e.message, e)
      @failed_tests += 1
    end
  end
end

TestRunner.new.run
