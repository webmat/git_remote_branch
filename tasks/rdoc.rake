require 'rake/rdoctask'

RDOC_TITLE = "readme for #{GitRemoteBranch::NAME}"

desc 'Generate rdoc documentation.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = RDOC_TITLE
  rdoc.rdoc_files.include('README.rdoc')
end
