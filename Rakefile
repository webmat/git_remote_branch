require 'rubygems'

require 'rake'
require 'rake/testtask'
require 'rake/gempackagetask'

HERE = File.dirname(__FILE__)

require "#{HERE}/lib/git_remote_branch"


#Stuff gleaned from merb-core's Rakefile
NAME = 'git_remote_branch'
windows = (RUBY_PLATFORM =~ /win32|cygwin/) rescue nil
install_home = ENV['GEM_HOME'] ? "-i #{ENV['GEM_HOME']}" : ""
SUDO = windows ? "" : "sudo"


Rake::TestTask.new(:test) do |t|
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

task :default => :test

gem_spec = eval(File.read("#{HERE}/git_remote_branch.gemspec"))

namespace :gem do
  #Creates clobber_package, gem,  package, repackage tasks
  #Note on clobber_package: fortunately, this will clobber the CODE package
  Rake::GemPackageTask.new(gem_spec) do |pkg| 
    pkg.need_tar = true 
  end

  #Tasks gleaned from merb-core's Rakefile

  desc "Run :gem and install the resulting .gem"
  task :install => :gem do
    cmd = "#{SUDO} gem install #{install_home} --local pkg/#{NAME}-#{GitRemoteBranch::VERSION}.gem --no-rdoc --no-ri"
    puts cmd
    `#{cmd}`
  end

  desc "Uninstall the .gem"
  task :uninstall do
    `#{SUDO} gem uninstall #{NAME}`
  end
end
