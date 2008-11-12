module GitRemoteBranch
  include ::CaptureFu
  
  private
    BRANCH_LISTING_COMMAND = 'git branch -l'.freeze
  
  public
    def get_current_branch
      #This is sensitive to checkouts of branches specified with wrong case
      
      listing = capture_process_output("#{BRANCH_LISTING_COMMAND}")[1]
      raise(NotOnGitRepositoryError, listing.chomp) if listing =~ /Not a git repository/i
      
      current_branch = listing.scan(/^\*\s+(.+)/).flatten.first
      
      if current_branch =~ /\(no branch\)/
        raise InvalidBranchError, ["Couldn't identify the current local branch. The branch listing was:",
          BRANCH_LISTING_COMMAND.red, 
          listing].join("\n")
      end
      current_branch.strip
    end
end