require 'fileutils'
require 'tmpdir'

class TempDirHelper
  include FileUtils
  
  attr_reader :directory

  def initialize(namespace='temp_dir_helper')
    @directory = get_temp_dir!(namespace)
  end
  
  def cleanup
    rm_rf @directory
  end
  
  def to_s
    directory
  end
  
  private
    def get_temp_dir!(namespace='')
      wd = File.expand_path( File.join( Dir::tmpdir, namespace) )
      mkdir wd unless File.exists? wd
      
      #Create new subdir with a random name
      new_dir=''
      begin
        new_dir = File.join( wd, "#{rand(10000)}" )
        mkdir new_dir
        
      rescue
        retry
      end
      
      new_dir
    end
end
