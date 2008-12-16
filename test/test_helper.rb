require 'rubygems'
require 'test/unit'

TEST_DIR = File.dirname(__FILE__)

# Install version 2 the shoulda gem with 
#   gem install thoughtbot-shoulda --source http://gems.github.com
# Shoulda depends on ActiveSupport 2.0, so if you don't have Rails 2.x installed, install ActiveSupport before Shoulda:
#   gem install activesupport
gem 'thoughtbot-shoulda', '~> 2.0'
require 'shoulda'
gem 'mocha', '~> 0.5'
require 'mocha'

# Just load redgreen if not running tests from TextMate
IN_TM = !ENV['TM_DIRECTORY'].nil? unless defined?(IN_TM)
begin
  require 'redgreen' unless IN_TM
rescue LoadError => ex
  puts "Couldn't load optional test dependencies: #{ex.inspect}"
end

require File.join( [TEST_DIR] + %w{ .. lib git_remote_branch} )

require "#{TEST_DIR}/helpers/in_dir"
Dir[TEST_DIR+'/helpers/**/*.rb'].each{|f| require f} 

class Test::Unit::TestCase
  include MoreAssertions

  attr_reader :grb
  def setup
    @grb = Object.new
    @grb.send :extend, GitRemoteBranch
  end
end
