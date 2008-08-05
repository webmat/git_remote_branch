class DirStack
  attr_reader :dir_stack
  
  def current_dir
    dir_stack.size == 0 ? Dir.pwd : dir_stack.last
  end
  
  def pushd(dirname)
    dir_stack.push(File.expand_path(dirname))
  end
  
  def popd
    return [] if dir_stack.size==0
    dir_stack.pop
    dir_stack
  end
  
  def to_s
    dir_stack.inspect
  end
  
  def initialize
    @dir_stack = []
  end
end
