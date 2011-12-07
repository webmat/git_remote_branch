module GitRemoteBranch
  GIT = (ENV['GRB_GIT'] || 'git')

  LOCAL_BRANCH_LISTING_COMMAND = "#{GIT} branch -l"
end
