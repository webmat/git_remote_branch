module GitRemoteBranch
  private 
  HELP_PARAMS = {:action => :help}

  public
  def read_params(argv)
    #TODO Some validation on the params
    
    p={}
    p[:silent]  = silent!(argv)
    p[:explain] = explain_mode!(argv)
    
    p[:action]  = get_action(argv[0]) or return HELP_PARAMS

    return HELP_PARAMS if p[:action] == :help

    p[:branch]  = get_branch(argv[1])
    p[:origin]  = get_origin(argv[2])
    
    # If in explain mode, the user doesn't have to specify a branch or be on in
    # actual repo to get the explanation. 
    # Of course if he is, the explanation will be made better by using contextual info.
    if p[:explain]
      p[:branch] ||= "branch_to_#{p[:action]}"
      p[:current_branch] = begin
        get_current_branch
      rescue 
        'current_branch'
      end

    else
      return HELP_PARAMS unless p[:branch]
      p[:current_branch] = get_current_branch
    end
    return p
  end

  def explain_mode!(argv)
    if argv[0].to_s.downcase == 'explain'
      argv.shift
      true
    else
      false
    end
  end
  
  def silent!(argv)
    !!argv.delete('--silent')
  end

  def get_action(action)
    ALIAS_REVERSE_MAP[action.to_s.downcase]
  end

  def get_branch(branch)
    branch
  end
  
  def get_origin(origin)
    return origin || 'origin'
  end

  private
  BRANCH_LISTING_COMMAND = 'git branch -l'.freeze
  
  public
  def get_current_branch
    #This is sensitive to checkouts of branches specified with wrong case
    
    x = `#{BRANCH_LISTING_COMMAND}`
    x.each_line do |l|
      return l.sub("*","").strip if l =~ /\A\*/ and not l =~ /\(no branch\)/
    end
    raise InvalidBranchError, ["Couldn't identify the current local branch. The branch listing was:",
      BRANCH_LISTING_COMMAND.red, 
      x].join("\n")
  end
end
