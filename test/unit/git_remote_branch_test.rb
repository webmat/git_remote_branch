require File.join( File.dirname(__FILE__), '..', 'test_helper')

class GitRemoteBranchUnitTest < Test::Unit::TestCase
  context 'help' do
    should 'contain examples for all basic commands' do
      GitRemoteBranch::COMMANDS.keys.each do |k|
        assert_match "grb #{k} branch_name", grb.get_usage
      end
    end
    
    should 'contain an example for explain' do
      assert_match 'grb explain', grb.get_usage
    end
    
    should 'contain an enumeration of all aliases' do
      GitRemoteBranch::COMMANDS.each_pair do |k,v|
        assert_match "#{k}: #{v[:aliases].join(', ')}", grb.get_usage
      end
    end
  end
end
