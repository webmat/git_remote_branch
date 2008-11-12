require 'rake/rdoctask'

desc 'Generate rdoc documentation'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = GitRemoteBranch::NAME
  rdoc.rdoc_files.include('README.rdoc')
end

desc 'Upload rdoc documentation'
task :upload_rdoc => :rdoc do
  now = Time.now
  puts 'Deleting previous rdoc'
  `ssh programblings.com 'rm -Rf grb/rdoc'`
  
  puts "Uploading current rdoc"
  `scp -r #{GRB_ROOT}/rdoc programblings.com:/home/mat/grb`
end
