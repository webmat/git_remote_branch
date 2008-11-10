require 'rubygems'
require 'test/unit'

test_dir = File.dirname(__FILE__)

# Install the non-Rails shoulda gem with 'gem install Shoulda'
# Notice the capitalization in the name.
require 'shoulda'
require 'mocha'

# Just load redgreen if not running tests from TextMate
IN_TM = !ENV['TM_DIRECTORY'].nil? unless defined?(IN_TM)
begin
  require 'redgreen' unless IN_TM
  require 'ruby-debug'
rescue LoadError => ex
  puts "Couldn't load optional test dependencies.\n  #{ex.inspect}"
end

require File.join( [test_dir] + %w{ .. lib git_remote_branch} )

Dir[test_dir+'/helpers/**/*.rb'].each{|f| require f} 

class Test::Unit::TestCase
  include MoreAssertions

  attr_reader :grb
  def setup
    @grb = Object.new
    @grb.send :extend, GitRemoteBranch
  end
end
