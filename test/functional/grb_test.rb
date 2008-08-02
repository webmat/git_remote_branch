require File.join( File.dirname(__FILE__), '..', 'test_helper')

class GRBTest < Test::Unit::TestCase
  include ShouldaFunctionalHelpers
  
  on_a_new_repo do
    in_directory_for :local1 do
      context "creating a branch" do
        setup do
          run_with "create new_branch"
        end
        
        should_create_branch 'new_branch', :local
        should_create_branch 'new_branch', :remote
        
        in_directory_for :remote do
          should_create_branch 'new_branch', :local
        end
      end
    end
  end
end
