class CommandLineFormatter
  def test_fixture_start fixture_name
    p fixture_name
  end
  
  def test_fixture_end fixture_name
    puts
  end

  def test_passed(method_name)
    green humanize method_name
  end

  def test_failed(method_name, message, e = nil)
    red humanize(method_name)
    red message
    red e.backtrace unless e.nil?
  end
  
  def summary(count, failed_count)
    puts "#{count} tests run, #{failed_count} failed"    
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
