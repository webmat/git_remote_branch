# Reminder when shipping a version
# - Bump the version in lib/version.rb
# - Commit & push everything
# - rake gem gem:install # then sanity check that it works
# - rake gem:feeling_lucky # uploads the gem, then tags the commit

require 'yaml'

gem_name  = GitRemoteBranch::NAME
version   = GitRemoteBranch::VERSION::STRING
gem_file  = "#{gem_name}-#{version}.gem"

tag_command = "git tag -m 'Tagging version #{version}' -a v#{version}"
push_tags_command = 'git push --tags'

task :tag_warn do
  puts <<-TAG
#{"*" * 40}
Don't forget to tag the release:

  #{tag_command}
  #{push_tags_command}
or
  run rake tag tag:push

#{"*" * 40}
TAG
end

task :tag do
  sh tag_command
  puts "Upload tags to repo with '#{push_tags_command}'"
end

namespace :tag do
  task :push do
    sh push_tags_command
  end
end

desc "Build gem and put it in pkg/"
task :gem => [:test, :tag_warn] do
  sh "gem build #{gem_name}.gemspec && mv #{gem_file} pkg/"
end

namespace :gem do
  desc 'Upload gem to rubygems.org'
  task :publish => :gem do
    sh "gem push pkg/#{gem_file}"
  end

  desc 'Install the last gem built locally'
  task :install do
    sh "gem install pkg/#{gem_file}"
  end

  desc "Uninstall version #{version} of the gem"
  task :uninstall do
    sh "gem uninstall -v #{version} -x #{gem_name}"
  end

  desc "Build and publish the gem, tag the commit and push the tags in one command"
  task :feeling_lucky => [:gem, :publish, :tag, 'tag:push']
end
