require 'rake/testtask'

desc "Run all tests"
Rake::TestTask.new(:test) do |t|
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

namespace :test do
  desc "Run functional tests"
  Rake::TestTask.new(:functional) do |t|
    t.pattern = 'test/functional/**/*_test.rb'
    t.verbose = true
  end

  desc "Run unit tests"
  Rake::TestTask.new(:unit) do |t|
    t.pattern = 'test/unit/**/*_test.rb'
    t.verbose = true
  end
end
