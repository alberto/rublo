Dir.entries(File.dirname(__FILE__)).each do |file|
  require_relative file if file =~ /_test\.rb/
end

require_relative 'test'

class TestRunner
  def run
    number_of_tests = 0
    failed_tests = 0
    test_classes = Test.descendants
    test_classes.each do |klass|
      p klass
      methods = klass.new.methods - Object.methods - Test.instance_methods
      number_of_tests += methods.count
      methods.each do |method|
        begin
          k = klass.new
          k.send(method)
          green humanize(method.to_s)
        rescue TestException => e      
          failed_tests +=1
          red humanize(method.to_s)
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
  end
  
  def humanize text
    text.gsub!('_', ' ')
    text
  end

  def colorize(text, color_code)
    puts "#{color_code}  #{text}\e[0m"
  end

  def red text
    colorize(text, "\e[31m")
  end

  def green text
    colorize(text, "\e[32m")
  end
end

TestRunner.new.run
