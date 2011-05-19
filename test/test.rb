class Test
  def assert_equals expected, actual
    if expected == actual
      p "ok"
    else
      p not_equals(expected, actual)
    end    
  end

  def not_equals expected, actual
    "Expected #{expected}, but got #{actual}"
  end
end
