require 'yaml'

require 'rubygems/package_task'

spec = Gem::Specification.new do |s|
  s.name                  = GitRemoteBranch::NAME.dup
  s.version               = GitRemoteBranch::VERSION::STRING.dup
  s.summary               = "git_remote_branch eases the interaction with remote branches"
  s.description           = "git_remote_branch is a learning tool to ease the interaction with " +
                            "remote branches in simple situations."

  s.authors               = ['Mathieu Martin', 'Carl Mercier']
  s.email                 = "webmat@gmail.com"
  s.homepage              = "http://github.com/webmat/git_remote_branch"
  s.rubyforge_project     = 'grb'

  s.has_rdoc              = true
  s.extra_rdoc_files     << 'README.rdoc'
  s.rdoc_options         << '--main' << 'README.rdoc' << '--exclude' << 'lib'

  s.test_files            = Dir['test/**/*'].reject{|f| f =~ /test_runs/}
  s.files                 = Dir['**/*'].reject{|f| f =~ /\Apkg|\Acoverage|\Ardoc|test_runs|\.gemspec\Z/}

  s.executable            = 'grb'
  s.bindir                = "bin"
  s.require_path          = "lib"

  s.add_dependency( 'rainbow', '>= 1.0.1' )
end

#Creates clobber_package, gem, package and repackage tasks
#Note on clobber_package: fortunately, this will clobber the CODE package
Gem::PackageTask.new(spec) do |p|
  p.gem_spec = spec
end

TAG_COMMAND = "git tag -m 'Tagging version #{GitRemoteBranch::VERSION::STRING}' -a v#{GitRemoteBranch::VERSION::STRING}"
push_tags_command = 'git push --tags'
task :tag_warn do
  puts  "*" * 40,
        "Don't forget to tag the release:",
        '',
        "  " + TAG_COMMAND,
        '',
        "or run rake tag",
        "*" * 40
end
task :tag do
  sh TAG_COMMAND
  puts "Upload tags to repo with '#{push_tags_command}'"
end
task :gem => :tag_warn

namespace :gem do
  desc 'Upload gem to rubygems.org'
  task :publish => :gem do
    sh "gem push pkg/#{spec.full_name}.gem"
  end

  desc 'Install the gem built locally'
  task :install => [:clean, :gem] do
    sh "gem install pkg/#{spec.full_name}.gem"
  end

  desc "Uninstall version #{GitRemoteBranch::VERSION::STRING} of the gem"
  task :uninstall do
    sh "gem uninstall -v #{GitRemoteBranch::VERSION::STRING} -x #{GitRemoteBranch::NAME}"
  end

  desc "Build and publish the gem, tag the commit and push the tags in one command"
  task :feeling_lucky => [:gem, :publish, :tag] do
    sh push_tags_command
  end

  if WINDOWS
    win_spec = spec.dup
    win_spec.platform = Gem::Platform::CURRENT
    win_spec.add_dependency( 'win32console', '~> 1.1' ) # Missing dependency in the 'colored' gem

    desc "Generate the Windows version of the gem"
    namespace :windows do
      Rake::GemPackageTask.new(win_spec) do |p|
        p.gem_spec = win_spec
      end
    end
  end
end
