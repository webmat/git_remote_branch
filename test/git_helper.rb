require 'fileutils'
require 'tmpdir'

class GitHelper
  include FileUtils
  include GitRemoteBranch

  @@WORK_DIR = 'repo_test'
  
  attr_reader :remote, :local1, :local2
  
  def initialize
    @wd = get_temp_dir
    
    @remote = init_repo(@wd, 'remote')
    @local1 = clone_repo(@remote, @wd, 'local1')
    @local2 = clone_repo(@remote, @wd, 'local2')
  end
  
  def cleanup
    rm_rf @wd
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
