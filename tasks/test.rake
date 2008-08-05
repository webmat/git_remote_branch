require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

namespace :test do
  Rake::TestTask.new(:functional) do |t|
    t.pattern = 'test/functional/**/*_test.rb'
    t.verbose = true
  end

  Rake::TestTask.new(:unit) do |t|
    t.pattern = 'test/unit/**/*_test.rb'
    t.verbose = true
  end
end
