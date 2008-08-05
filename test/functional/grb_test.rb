require File.join( File.dirname(__FILE__), '..', 'test_helper')

class GRBTest < Test::Unit::TestCase
  include ShouldaFunctionalHelpers
  
  on_a_repository do
    context "creating a branch in a local clone" do
      setup do
        in_directory_for :local1
        #assert_match(/local1\Z/, execute('pwd').chomp) #Sanity check
        
        run_with 'create new_branch'
      end
      
      should_have_branch 'new_branch', :local
      should_have_branch 'new_branch', :remote
      
      context "the remote repository" do
        setup do
          in_directory_for :remote
        end
        
        should_have_branch 'new_branch', :local
      end
      
      context "the other local clone, tracking the new branch" do
        setup do
          in_directory_for :local2
          assert_match(/local2\Z/, execute('pwd').chomp) #Sanity check
          
          run_with 'track new_branch'
        end
        
        should_have_branch 'new_branch', :local
        should_have_branch 'new_branch', :remote
      end
      
      context "then deleting the branch" do
        setup do
          run_with 'delete new_branch'
        end
        
        should_not_have_branch 'new_branch', :local
        should_not_have_branch 'new_branch', :remote
        
        context "the remote repository" do
          setup do
            in_directory_for :remote
          end

          should_not_have_branch 'new_branch', :local
        end
      end
    end
  end
end
