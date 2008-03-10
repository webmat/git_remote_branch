require File.join(File.dirname(__FILE__), 'test_helper')

class GitHelperTest < Test::Unit::TestCase
  
  def setup
    @g = GitHelper.new
    @directories = [@g.remote, @g.local1, @g.local2]
  end
  
  def teardown
    @g.cleanup
  end
  
  def test_init
    @directories.each do |d|
      assert File.exists?(@g.remote), 'Directory for repo must be created'
      assert File.exists?( File.join(@g.remote, '.git') ), 'Repo must be created'
    end
  end
  
  def test_cleanup
    @g.cleanup
    
    @directories.each do |d|
      assert_false File.exists?(@g.remote), 'Each repo directory must be destroyed after cleanup'
    end
  end
  
end