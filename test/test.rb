class Test
  def assert_equals expected, actual
    if expected == actual
      puts 'ok'
    else
      puts not_equals(expected, actual)
    end    
  end

  def not_equals expected, actual
    "Expected #{expected.inspect}, but got #{actual.inspect}"
  end

  def assert_fail
    puts "Test failed"
  end

  def assert_pass
    assert_equals true, true
  end
end
