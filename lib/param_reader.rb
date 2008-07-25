module GitRemoteBranch
  def read_params(argv)
    #TODO Some validation on the params
    
    p={}
    p[:explain]        = explain_mode!(argv)
    p[:action]         = get_action(argv[0]) || :help

    return p if p[:action] == :help

    p[:branch]         = get_branch(argv[1])
    p[:origin]         = get_origin(argv[2])

    # If in explain mode, the user doesn't have to specify a branch or be on in
    # actual repo to get the explanation. 
    # Of course if he is, the explanation can be made better.
    if p[:explain]
      p[:branch] ||= "branch_to_#{p[:action]}"
      p[:current_branch] = begin
        get_current_branch
      rescue 
        'current_branch'
      end

    else
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

  def get_action(action)
    a = action.to_s.downcase
    return :create if COMMANDS[:create][:aliases].include?(a)
    return :delete if COMMANDS[:delete][:aliases].include?(a)
    return :track  if COMMANDS[:track][:aliases].include?(a)
    return :rename if COMMANDS[:rename][:aliases].include?(a)
    return nil
  end

  def get_branch(branch)
    branch
  end
  
  def get_origin(origin)
    return origin || 'origin'
  end

  def get_current_branch
    #This is sensitive to checkouts of branches specified with wrong case
    x = `git branch -l`
    x.each_line do |l|
      return l.sub("*","").strip if l =~ /\A\*/ and not l =~ /\(no branch\)/
    end
    raise "Couldn't identify the current local branch."
  end
end
