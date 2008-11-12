require File.join( File.dirname(__FILE__), '..', 'test_helper')
require "#{TEST_DIR}/helpers/constants"

class ParamReaderTest < Test::Unit::TestCase
  include ShouldaUnitHelpers
  
  context 'get_current_branch' do
    context "when not on a git repository" do
      setup do
        grb.stubs(:capture_process_output).returns([128, WHEN_NOT_ON_GIT_REPOSITORY])
      end
      
      should "raise an exception" do
        assert_raise(GitRemoteBranch::NotOnGitRepositoryError) { grb.get_current_branch }
      end
    end

    context "when on an invalid branch" do
      setup do
        grb.stubs(:capture_process_output).returns([0, BRANCH_LISTING_WHEN_NOT_ON_BRANCH])
      end
      
      should "raise an exception" do
        assert_raise(GitRemoteBranch::InvalidBranchError) { grb.get_current_branch }
      end
    end

    context "when on a valid branch" do
      setup do
        grb.stubs(:capture_process_output).returns([0, REGULAR_BRANCH_LISTING])
      end
      
      should "return the current branch name" do
        assert_equal 'stubbed_current_branch', grb.get_current_branch
      end
    end
  end
end
