require 'fileutils'
require 'tmpdir'

# Instantiating a GitHelper object creates a temp directory containing 3 repos.
# 1 that's considered the remote repo and 2 peer local repos (local1 and local2).
# All 3 are synchronized with the same data (they contain a few dummy files).
# Once instantiated you can access the 3 full repo locations through attribute readers
# remote, local1 and local2.
class GitHelper
  include FileUtils

  @@WORK_DIR = 'repo_test'
  
  attr_reader :remote, :local1, :local2, :non_git
  
  def initialize
    @common_directory = get_temp_dir
    
    @remote  = init_repo(@common_directory, 'remote')
    @local1  = clone_repo(@remote, @common_directory, 'local1')
    @local2  = clone_repo(@remote, @common_directory, 'local2')
    @non_git = File.join(@common_directory, 'non_git')
  end
  
  def cleanup
    rm_rf @common_directory
  end
  
  protected
  def get_temp_dir
    #Note: it's NOT a good idea to do this stuff un a subdirectory of the 
    #git_remote_branch repo. Trust me :-)
    wd = File.expand_path( File.join( Dir::tmpdir, @@WORK_DIR) )
    Dir.mkdir wd unless File.exists? wd
    
    #Create new subdir with a random name
    new_dir=''
    begin
      new_dir = File.join( wd, "#{rand(10000)}" )
      Dir.mkdir new_dir
      Dir.mkdir File.join( new_dir, 'non_git' )
    rescue
      retry
    end
    
    new_dir
  end
  
  def init_repo(path, name)
    repo_dir = File.join(path, name)
    `mkdir #{repo_dir}; cd $_; git init; touch file.txt; git add .; git commit -a -m "dummy file"`
    repo_dir
  end
  
  def clone_repo(origin_path, clone_path, name)
    `cd #{clone_path}; git clone #{File.join(origin_path, '.git')} #{name}`
    return File.join(clone_path, name)
  end
end
