require 'rubygems'
require 'test/unit'
#begin; require 'ruby-debug'; rescue; end   #I know I'll forget to comment it out one day :-)

require File.join(File.dirname(__FILE__), 'git_helper')


class Test::Unit::TestCase
  
  # Passes assertion if condition is false  
  def assert_false(condition, message = nil)
    message = "assert_false failed" unless message
    assert condition == false, message
  end
  
end