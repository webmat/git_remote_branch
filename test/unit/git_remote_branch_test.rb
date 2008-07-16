require File.join( File.dirname(__FILE__), '..', 'test_helper')

class GitRemoteBranchTest < Test::Unit::TestCase
  include GitRemoteBranch
  
  context 'help' do
    should 'contain examples for all basic commands' do
      COMMANDS.keys.each do |k|
        assert_match "grb #{k} branch_name", get_usage
      end
    end
    
    should 'contain an example for explain' do
      assert_match 'grb explain', get_usage
    end
    
    should 'contain an enumeration of all aliases' do
      COMMANDS.each_pair do |k,v|
        assert_match "#{k}: #{v[:aliases].join(', ')}", get_usage
      end
    end
  end
end
