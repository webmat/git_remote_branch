require File.join( File.dirname(__FILE__), '..', 'test_helper')

class ParamReaderTest < Test::Unit::TestCase
  include GitRemoteBranch
  
  def self.should_set_explain_to(truth)
    should "set explain to #{truth}" do
      assert_equal truth, @p[:explain]
    end
  end
  
  def self.should_set_action_to(action)
    should "set the action to #{action}" do
      assert_equal action, @p[:action]
    end
  end
  
  def self.should_set_current_branch_to(branch)
    should "set the current_branch to #{branch}" do
      assert_equal branch, @p[:current_branch]
    end
  end
  
  context 'read_params' do
    context "when on a valid branch" do
      setup do
        stubs(:get_current_branch).returns('stubbed_current_branch')
      end
      
      context "on an 'explain' command" do
        context "with no information provided other than the action" do
          setup do
            @p = read_params %w{explain create}
          end
          
          should_set_explain_to         true
          should_set_action_to          :create
          should_set_current_branch_to  'stubbed_current_branch'
          
          should "default to origin 'origin'" do
            assert_equal 'origin', @p[:origin]
          end
          
          should "set a dummy new branch name" do
            assert @p[:branch]
          end
        end
        
        context "with all information provided" do
          setup do
            @p = read_params %w{explain create specific_branch specific_origin}
          end
          
          should_set_explain_to         true
          should_set_action_to          :create
          should_set_current_branch_to  'stubbed_current_branch'
          
          should "set the origin to 'specific_origin'" do
            assert_equal 'specific_origin', @p[:origin]
          end
          
          should "set the specified branch name" do
            assert_equal 'specific_branch', @p[:branch]
          end
        end
      end
      
      context "on a 'help' command" do
      end
      
      context "on normal valid command" do
      end
      
      context "on an invalid command" do
      end
    end
  end
  
  context 'explain_mode!' do
    context "when it receives an array beginning with 'explain'" do
      setup do
        @array  = ['explain', 'create', 'some_branch']
      end

      should "return true" do
        assert explain_mode!(@array)
      end

      should 'accept symbol arrays as well' do
        assert explain_mode!( @array.map{|e| e.to_sym} )
      end

      should "remove 'explain' from the argument array" do
        explain_mode!(@array)
        assert_equal ['create', 'some_branch'], @array
      end
    end

    context "when it receives an array that doesn't begin with 'explain'" do
      setup do
        @array  = ['create', 'some_branch']
      end

      should "return false" do
        assert_false explain_mode!(@array)
      end

      should "not modify the argument array" do
        explain_mode!(@array)
        assert_equal ['create', 'some_branch'], @array
      end
    end
  end
  
  context 'get_action' do
    COMMANDS.each_pair do |cmd, params|
      should "recognize all #{cmd} aliases" do
        params[:aliases].each do |alias_|
          assert cmd, get_action(alias_) 
        end
      end
    end
    should 'return nil on unknown aliases' do
      assert_nil get_action('please_dont_create_an_alias_named_like_this')
    end  
  end

  context 'get_origin' do
    should "default to 'origin' when the param is nil" do
      assert_equal 'origin', get_origin(nil)
    end
    should "return the unchanged param if it's not nil" do
      assert_equal 'someword', get_origin('someword')
    end
  end
end