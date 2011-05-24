class TestException < Exception
end
class Test
  def initialize
    @failed = false
  end

  def failed?
    @failed
  end

  def assert_equals expected, actual    
    if expected != actual
      raise TestException.new(not_equals(expected, actual))
      @failed = true
    end
  end

  def assert_fail message = "Test failed"
    raise TestException.new(not_equals(expected, actual))
    @failed = true
  end

  def assert_pass
    assert_equals true, true
  end

  def assert_true actual
    assert_equals true, actual
  end

  def assert_false actual
    assert_equals false, actual
  end

  private
    def not_equals expected, actual
      "Expected #{expected.inspect}, but got #{actual.inspect}"
    end
end

def with_replaced_method(cls, meth, new_impl)
    replace_class_method(cls, meth, new_impl)
    begin
        result = yield
    ensure
        restore_class_method(cls, meth)
    end
    return result
end

private
def replace_class_method(cls, meth, new_impl)
  cls.class_eval("class << self; alias_method :old_#{meth}, :#{meth}; end")
  cls.class_eval(new_impl)
end

def restore_class_method(cls, meth)
  cls.class_eval("class << self; alias_method :#{meth}, :old_#{meth}; end")
end

