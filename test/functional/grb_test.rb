require File.join( File.dirname(__FILE__), '..', 'test_helper')

class GRBTest < Test::Unit::TestCase
  include ShouldaFunctionalHelpers

  on_a_repository do
    context "creating a branch in a local clone" do
      setup do
        in_directory_for :local1
        run_grb_with 'create new_branch'
      end
      
      should_have_branch 'new_branch', :local, :remote
      
      context "the remote repository" do
        setup do
          in_directory_for :remote
        end
        
        should_have_branch 'new_branch', :local
      end
      
      context "the other local clone" do
        setup do
          in_directory_for :local2
        end
        
        context "not already having a branch of the same name" do
          setup do
            @output = run_grb_with 'track new_branch'
          end
          
          should_have_branch 'new_branch', :local, :remote
          
          should "use the branch --track command" do
            assert_match %r{branch --track}, @output
          end
        end
        
        context "having a branch of the same name" do
          setup do
            execute "git branch new_branch"
            @output = run_grb_with 'track new_branch'
          end
          
          should_have_branch 'new_branch', :local, :remote
          
          should "use git config to connect the branches" do
            assert_match %r{git\sconfig}, @output
          end
        end
      end
      
      context "then deleting the branch" do
        setup do
          run_grb_with 'delete new_branch'
        end
        
        should_not_have_branch 'new_branch', :local, :remote
        
        context "the remote repository" do
          setup do
            in_directory_for :remote
          end

          should_not_have_branch 'new_branch', :local
        end
      end
      
      context "renaming the branch" do
        setup do
          in_directory_for :local1
          in_branch :new_branch
          run_grb_with 'rename renamed_branch'
        end

        should_not_have_branch 'new_branch', :local, :remote
        should_have_branch 'renamed_branch', :local, :remote

        context "the remote repository" do
          setup do
            in_directory_for :remote
          end

          should_not_have_branch 'new_branch', :local
          should_have_branch 'renamed_branch', :local
        end
      end
    end
    
    context "having a local only branch" do
      setup do
        in_directory_for :local1
        execute "git branch my_branch"
      end
      
      should_have_branch 'my_branch', :local #Sanity check
      
      context "remotizing the branch" do
        setup do
          run_grb_with 'publish my_branch'
        end
        
        should_have_branch 'my_branch', :remote
        
        context "the remote repository" do
          setup do
            in_directory_for :remote
          end

          should_have_branch 'my_branch', :local
        end
      end
    end
    
    context "running grb with a detailed explain" do
      setup do
        in_directory_for :local1
        @text = run_grb_with 'explain create teh_branch somewhere'
      end
      
      should "display the commands to run with the user-specified values, including current_branch" do
        %w{master somewhere refs/heads/teh_branch}.each do |word|
          assert_match(/#{word}/, @text)
        end
      end
    end
  end

  in_a_non_git_directory do
    context "displaying help" do
      setup do
        @text = run_grb_with 'help'
      end
      
      should "work" do
        words_in_help = %w{create delete explain git_remote_branch}
        words_in_help.each do |word|
          assert_match(/#{word}/, @text)
        end
      end
      
      should "not complain" do
        assert_no_match(/not a git repository/i, @text)
      end
    end
    
    context "running grb with a generic explain" do
      setup do
        @text = run_grb_with 'explain create'
      end
      
      should "display the commands to run with dummy values filled in" do
        #Not sure if this will turn out to be too precise to my liking...
        generic_words_in_explain_create = %w{
          origin current_branch refs/heads/branch_to_create
          git push fetch checkout}
        generic_words_in_explain_create.each do |word|
          assert_match(/#{word}/, @text)
        end
      end
    end
    
    context "running grb with a detailed explain" do
      setup do
        @text = run_grb_with 'explain create teh_branch somewhere'
      end
      
      should "display the commands to run with the user-specified values (except for current_branch)" do
        %w{somewhere current_branch refs/heads/teh_branch}.each do |word|
          assert_match(/#{word}/, @text)
        end
      end
    end
  end
end
