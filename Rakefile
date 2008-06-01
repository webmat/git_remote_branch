require 'rubygems'

require 'rake'
require 'rake/testtask'


Rake::TestTask.new(:test) do |t|
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

task :default => :test

