module InDir
  def in_dir(dir, &block)
    prev_dir = Dir.pwd
    Dir.chdir dir
    
    yield
  ensure
    Dir.chdir prev_dir
  end
end