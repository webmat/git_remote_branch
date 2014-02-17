# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'version'

Gem::Specification.new do |s|
  s.name        = GitRemoteBranch::NAME
  s.version     = GitRemoteBranch::VERSION::STRING
  s.license     = 'MIT'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Mathieu Martin", "Carl Mercier"]
  s.email       = "webmat@gmail.com"
  s.homepage    = "http://github.com/webmat/git_remote_branch"
  s.summary     = %Q{git_remote_branch eases the interaction with remote branches}
  s.description = %Q{git_remote_branch is a learning tool to ease the interaction with remote branches in simple situations.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- test/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rake"
  s.add_development_dependency "rdoc"
  s.add_development_dependency 'test-unit'
  s.add_development_dependency 'shoulda'
  s.add_development_dependency 'mocha'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'pry-nav'
end
