module GitRemoteBranch
  def read_params(argv)
    p={}
    p[:explain] = explain_mode!(argv)
    p[:action] = get_action(argv[0])
    p[:branch] = get_branch(argv[1])
    p[:origin] = get_origin(argv[2])
    p[:current_branch] = get_current_branch

    #If in explain mode, the user doesn't have to specify a branch to get the explanation
    p[:branch] ||= "branch_to_#{p[:action]}" if [:explain]

    #TODO Some validation on the params

    p
  end

  def explain_mode!(argv)
    if argv[0].downcase == 'explain'
      argv.shift
      true
    else
      false
    end
  end

  def get_action(action)
    a = action.downcase
    return :create if COMMANDS[:create][:aliases].include?(a)
    return :delete if COMMANDS[:delete][:aliases].include?(a)
    return :track  if COMMANDS[:track][:aliases].include?(a)
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
