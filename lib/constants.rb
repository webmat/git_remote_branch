module GitRemoteBranch
  GIT = (ENV['GRB_GIT'] || 'git').freeze
  
  LOCAL_BRANCH_LISTING_COMMAND = "#{GIT} branch -l".freeze
end
