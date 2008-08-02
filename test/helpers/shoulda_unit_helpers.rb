module ShouldaUnitHelpers
  def self.included(base)
    base.extend( ClassMethods )
    add_param_checkers(base)
  end
  
  def self.add_param_checkers(base)
    # Excuse my french but:
    %w(action branch origin current_branch silent explain).each do |param|
      base.instance_eval(%Q!
        def self.should_set_#{param}_to(#{param}_value)
          should "set #{param} to #{ '#{' }#{ param }_value}" do
            assert_equal #{param}_value, @p[:#{param}]
          end
        end
      !)
    end
    # In other words, create a bunch of helpers like:
    # 
    # def self.should_set_explain_to(explain_value)
    #   should "set explain to #{explain_value}" do
    #     assert_equal explain_value, @p[:explain]
    #   end
    # end
    
  end
  
  module ClassMethods   
    def should_return_help_for_parameters(params, context_explanation)
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
    
    def should_explain_with_current_branch(current_branch_value, current_branch_explanation)
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
  end
end
