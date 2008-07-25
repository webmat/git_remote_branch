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
  
  context "the reverse mapping for aliases" do
    GitRemoteBranch::COMMANDS.each_pair do |cmd, params|
      params[:aliases].each do |alias_|
        should "contain the alias #{alias_}" do
          assert GitRemoteBranch::ALIAS_REVERSE_MAP[alias_]
        end
      end
    end
    
    context "upon creation" do
      should "raise an exception when there are duplicates" do
        assert_raise(RuntimeError) do
          GitRemoteBranch.get_reverse_map( GitRemoteBranch::COMMANDS.merge(:new_command => {:aliases => ['create']}) )
        end
      end
    end
  end
end
