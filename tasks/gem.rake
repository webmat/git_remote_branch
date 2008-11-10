require 'yaml'

require 'rake/gempackagetask'

task :clean => :clobber_package

spec = Gem::Specification.new do |s|
  s.name                  = GitRemoteBranch::NAME
  s.version               = GitRemoteBranch::VERSION::STRING
  s.summary               = "git_remote_branch eases the interaction with remote branches"
  s.description           = "git_remote_branch is a learning tool to ease the interaction with " +
                            "remote branches in simple situations."

  s.authors               = ['Mathieu Martin', 'Carl Mercier']
  s.email                 = "webmat@gmail.com"
  s.homepage              = "http://github.com/webmat/git_remote_branch"
  s.rubyforge_project     = 'grb'

  s.has_rdoc              = false
  
  s.test_files            = Dir['test/**/*']
  s.files                 = Dir['**/*'].reject{|f| f =~ /\Apkg|\Acoverage|\Ardoc|\.gemspec\Z/}
  
  s.executable            = 'grb'
  s.bindir                = "bin"
  s.require_path          = "lib"
  
  s.add_dependency( 'colored', '>= 1.1' )
end

#Creates clobber_package, gem, package and repackage tasks
#Note on clobber_package: fortunately, this will clobber the CODE package
Rake::GemPackageTask.new(spec) do |p|
  p.gem_spec = spec
end

TAG_COMMAND = "git tag -m 'Tagging version #{GitRemoteBranch::VERSION::STRING}' -a v#{GitRemoteBranch::VERSION::STRING}"
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
end
task :gem => :tag_warn

namespace :gem do
  desc "Update the gemspec for GitHub's gem server"
  task :github do
    File.open("#{GitRemoteBranch::NAME}.gemspec", 'w'){|f| f.puts YAML::dump(spec) }
    puts "gemspec generated here: #{GitRemoteBranch::NAME}.gemspec"
  end
  
  desc 'Upload gem to rubyforge.org'
  task :rubyforge => :gem do
    sh 'rubyforge login'
    sh "rubyforge add_release grb grb '#{GitRemoteBranch::VERSION::STRING}' pkg/#{spec.full_name}.gem"
    sh "rubyforge add_file grb grb #{GitRemoteBranch::VERSION::STRING} pkg/#{spec.full_name}.gem"
  end
end

task :install => [:clean, :gem] do
  sh "#{SUDO} gem install pkg/#{spec.full_name}.gem"
end

task :uninstall do
  sh "#{SUDO} gem uninstall -v #{GitRemoteBranch::VERSION::STRING} -x #{GitRemoteBranch::NAME}"
end
