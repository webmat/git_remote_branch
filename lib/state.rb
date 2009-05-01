module GitRemoteBranch
  include ::CaptureFu
  
  public
    def get_current_branch
      local_branch_information[0]
    end
    
    def local_branches
      local_branch_information[1]
    end
    
    def git_found?
      ret, msg = capture_process_output "#{GIT} --version"
      ret == 0
    end
    
  private
    # Returns an array of 2 elements: [current_branch, [all local branches]]
    def local_branch_information
      #This is sensitive to checkouts of branches specified with wrong case
      
      listing = capture_process_output("#{LOCAL_BRANCH_LISTING_COMMAND}")[1]
      
      raise(NotOnGitRepositoryError, listing.chomp) if listing =~ /Not a git repository/i
      if listing =~ /\(no branch\)/
        raise InvalidBranchError, ["Couldn't identify the current local branch. The branch listing was:",
          LOCAL_BRANCH_LISTING_COMMAND.foreground(:red), 
          listing].join("\n")
      end
      
      current_branch = nil
      branches = listing.split("\n").map do |line| 
        current        = line.include? '*'
        clean_line     = line.gsub('*','').strip
        current_branch = clean_line if current
        clean_line
      end
      
      return current_branch, branches
    end
end
