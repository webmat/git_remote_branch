Gem::Specification.new do |s|
  s.name        = 'git_remote_branch'
  s.version     = '0.2.1'
  s.summary     = "git_remote_branch eases the interaction with remote branches"

  s.authors     = ['Mathieu Martin', 'Carl Mercier']
  s.email       = "webmat@gmail.com"
  s.homepage    = "http://github.com/webmat/git_remote_branch"
  s.description = "git_remote_branch is a learning tool to ease the interaction with " +
                  "remote branches in simple situations."

  s.test_files  = %w{test/git_helper.rb test/test_helper.rb test/unit/git_helper_test.rb}
  s.files       = %w{Rakefile README TODO bin/grb lib/git_remote_branch.rb
                  vendor/try_require/try_require.rb vendor/capture_fu/capture_fu.rb} + 
                  s.test_files
  s.bindir      = 'bin'
  s.executables = ['grb']
  s.has_rdoc    = false
end
