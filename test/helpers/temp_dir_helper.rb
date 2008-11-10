require 'fileutils'
require 'tmpdir'

class TempDirHelper
  include FileUtils
  
  attr_reader :directory

  def initialize(force_temp_dir=nil)
    @directory = get_temp_dir!(force_temp_dir)
  end
  
  def cleanup
    rm_rf @directory
  end
  
  def to_s
    directory
  end
  
  private
    def get_temp_dir!(parent_dir=nil)
      wd = File.expand_path( File.join( parent_dir || Dir::tmpdir) )
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
