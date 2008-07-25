require File.join( File.dirname(__FILE__), '..', 'test_helper')

REGULAR_BRANCH_LISTING = <<-STR
  other_user/master
* stubbed_current_branch
  rubyforge
STR

BRANCH_LISTING_WHEN_NOT_ON_BRANCH = <<-STR
* (no branch)
  other_user/master
  master
  rubyforge
STR

class ParamReaderTest < Test::Unit::TestCase
  # Excuse my french but:
  %w(explain action branch origin current_branch).each do |action|
    self.instance_eval(%Q!
      def self.should_set_#{action}_to(#{action}_value)
        should "set #{action} to #{ '#{' }#{ action }_value}" do
          assert_equal #{action}_value, @p[:#{action}]
        end
      end
    !)
  end
  # In other words, create a bunch of helpers like:
  # def self.should_set_explain_to(explain_value)
  #   should "set explain to #{explain_value}" do
  #     assert_equal explain_value, @p[:explain]
  #   end
  # end

  def self.should_return_help_for_parameters(params, context_explanation)
    context context_explanation do
      setup do
        @p = grb.read_params params
      end
      
      should "not even get to checking the current_branch" do
        grb.expects(:get_current_branch).never
        grb.read_params ['help']
      end
      
      should "only return a hash specifying the action" do
        assert_array_content [:action], @p.keys
      end
      
      should_set_action_to :help
    end
  end
  
  def self.should_explain_with_current_branch(current_branch_value, current_branch_explanation)
    context "on an 'explain' command" do
      context "with no information provided other than the action" do
        setup do
          @p = grb.read_params %w{explain create}
        end
        
        should_set_explain_to         true
        should_set_action_to          :create
        should_set_origin_to          'origin'
        
        context current_branch_explanation do
          should_set_current_branch_to  current_branch_value
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
        should_set_current_branch_to  current_branch_value
        
        should "set the origin to 'specific_origin'" do
          assert_equal 'specific_origin', @p[:origin]
        end
        
        should "set the specified branch name" do
          assert_equal 'specific_branch', @p[:branch]
        end
      end
    end
  end
  
  context 'read_params' do
    context "when on a valid branch" do
      setup do
        grb.stubs(:`).returns(REGULAR_BRANCH_LISTING)
      end
      
      context "on a normal valid command without an origin" do
        setup do
          @p = grb.read_params %w{create the_branch}
        end
        
        should_set_action_to :create
        should_set_branch_to 'the_branch'
        should_set_origin_to 'origin'
        should_set_current_branch_to 'stubbed_current_branch'
        should_set_explain_to false
      end

      context "on a normal valid command" do
        setup do
          @p = grb.read_params %w{create the_branch the_origin}
        end
        
        should_set_action_to :create
        should_set_branch_to 'the_branch'
        should_set_origin_to 'the_origin'
        should_set_current_branch_to 'stubbed_current_branch'
        should_set_explain_to false
      end

      should_explain_with_current_branch 'stubbed_current_branch', "use real current branch"
      
      should_return_help_for_parameters %w(help), "on a 'help' command"
      should_return_help_for_parameters %w(create), "on an incomplete command"
      should_return_help_for_parameters %w(decombobulate something), "on an invalid command"
    end
    
    context "when on an invalid branch" do
      setup do
        grb.stubs(:`).returns(BRANCH_LISTING_WHEN_NOT_ON_BRANCH)
      end
     
      should_explain_with_current_branch 'current_branch', "use a dummy value for the current branch"
      
      should_return_help_for_parameters %w(help), "on a 'help' command"
      should_return_help_for_parameters %w(create), "on an incomplete command"
      should_return_help_for_parameters %w(decombobulate something), "on an invalid command"
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
