require 'rake/rdoctask'

desc 'Generate rdoc documentation.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = GitRemoteBranch::NAME
  rdoc.rdoc_files.include('README.rdoc')
end
