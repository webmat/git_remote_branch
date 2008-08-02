module DirExtensions
  module ClassMethods
    def dir_stack
      @dir_stack
    end
    
    def pushd(dirname)
      full_dir = File.expand_path(dirname)
      chdir(full_dir)
      dir_stack.push(full_dir)
    end
    
    def popd
      return [] if dir_stack.size==0
      dir = dir_stack.pop
      chdir(dir)
      dir_stack
    end
  end
  
  def self.included(base)
    base.extend ClassMethods
    base.class_eval { @dir_stack = [] }
  end
end

Dir.send :include, DirExtensions
