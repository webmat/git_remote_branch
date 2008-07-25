require File.join( File.dirname(__FILE__), '..', 'test_helper')

class ParamReaderTest < Test::Unit::TestCase
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
  
  def self.should_return_help_for_parameters(params, context_explanation)
    context context_explanation do
      setup do
        @p = grb.read_params params
      end
      
      should "not even get to checking the current_branch" do
        grb.expects(:get_current_branch).never
        grb.read_params ['help']
      end
      
      should "not set other options in the returned hash" do
        assert_array_content [:action, :explain], @p.keys
      end
      
      should_set_action_to :help
      should_set_explain_to false
    end
  end
  
  context 'read_params' do
    context "when on a valid branch" do
      setup do
        grb.stubs(:get_current_branch).returns('stubbed_current_branch')
      end
      
      context "on an 'explain' command" do
        context "with no information provided other than the action" do
          setup do
            @p = grb.read_params %w{explain create}
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
            @p = grb.read_params %w{explain create specific_branch specific_origin}
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
      
      should_return_help_for_parameters %w(help), "on a 'help' command"
      should_return_help_for_parameters %w(decombobulate something), "on an invalid command"
      
      context "on normal valid command" do
      end
    end
  end
  
  context 'explain_mode!' do
    context "when it receives an array beginning with 'explain'" do
      setup do
        @array  = ['explain', 'create', 'some_branch']
      end

      should "return true" do
        assert grb.explain_mode!(@array)
      end

      should 'accept symbol arrays as well' do
        assert grb.explain_mode!( @array.map{|e| e.to_sym} )
      end

      should "remove 'explain' from the argument array" do
        grb.explain_mode!(@array)
        assert_equal ['create', 'some_branch'], @array
      end
    end

    context "when it receives an array that doesn't begin with 'explain'" do
      setup do
        @array  = ['create', 'some_branch']
      end

      should "return false" do
        assert_false grb.explain_mode!(@array)
      end

      should "not modify the argument array" do
        grb.explain_mode!(@array)
        assert_equal ['create', 'some_branch'], @array
      end
    end
  end
  
  context 'get_action' do
    GitRemoteBranch::COMMANDS.each_pair do |cmd, params|
      should "recognize all #{cmd} aliases" do
        params[:aliases].each do |alias_|
          assert cmd, grb.get_action(alias_) 
        end
      end
    end
    should 'return nil on unknown aliases' do
      assert_nil grb.get_action('please_dont_create_an_alias_named_like_this')
    end  
  end

  context 'get_origin' do
    should "default to 'origin' when the param is nil" do
      assert_equal 'origin', grb.get_origin(nil)
    end
    should "return the unchanged param if it's not nil" do
      assert_equal 'someword', grb.get_origin('someword')
    end
  end

end
