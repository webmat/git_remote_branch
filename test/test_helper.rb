require 'rubygems'
begin
  require 'bundler/setup'
rescue Bundler::GemNotFound => e
  STDERR.puts e.message
  STDERR.puts "Try running `bundle install`."
  exit!
end
require 'test/unit'

require 'shoulda'
require 'mocha'
require 'pry-nav'

TEST_DIR = File.dirname(__FILE__)

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
