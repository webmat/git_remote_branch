#require 'test/unit/assertionfailederror'
module MoreAssertions
  include Test::Unit

  def assert_false(condition, message = nil)
    unless condition == false
      raise AssertionFailedError, message || "assert_false failed"
    end
  end
  
  def assert_array_content(expected_array, array, message = nil)
    unless expected_array.count_all == array.count_all
      raise AssertionFailedError, message || "arrays did not have the same content. Expected #{expected_array.inspect}, got #{array.inspect}"
    end
  end
end
