GRB_VERSION = 0.2

def print_welcome
  puts "git-remote-branch #{GRB_VERSION} - by Carl Mercier (carl@carlmercier.com)"
  puts "----------------------------------------------------------------------"
  puts ""
end

def print_usage
  puts <<-HELP
Usage:

git-remote-branch create branch_name [origin_server]
-or-
git-remote-branch delete branch_name [origin_server]
-or-
git-remote-branch track branch_name [origin_server]

If origin_server is not specified, the name 'origin' is assumed
HELP
end

def execute_cmd(cmd)
  res, out, err = steal_pipes do
                                `#{cmd}`
                              end
  return res, out, err
end

def execute_cmds(*cmds)
  cmds.flatten.each do |c|
    puts "Executing: #{c}"
    `#{c}`
    puts ""
  end
end

def create_branch(branch_name, origin, current_branch)
  cmd = []
  cmd << "git push origin #{current_branch}:refs/heads/#{branch_name}"
  cmd << "git fetch #{origin}"
  cmd << "git branch --track #{branch_name} #{origin}/#{branch_name}"
  cmd << "git checkout #{branch_name}"
  execute_cmds(cmd)
end

def delete_branch(branch_name, origin, current_branch)
  cmd = []
  cmd << "git push #{origin} :refs/heads/#{branch_name}"
  cmd << "git checkout master" if current_branch == branch_name
  cmd << "git branch -d #{branch_name}"
  execute_cmds(cmd)
end

def track_branch(branch_name, origin)
  cmd = ["git branch --track #{branch_name} #{origin}/#{branch_name}"]
  execute_cmds(cmd)
end

def get_current_branch
  x = `git branch -l`
  x.each_line do |l|
    return l.sub("*","").strip if l[0] == 42
  end

  puts "Couldn't identify the current local branch."
  return nil
end

def get_action
  a = ARGV[0].downcase
  return :create if %w{create new}.include?(a)
  return :delete if %w{delete destroy kill}.include?(a)
  return :track  if %w{track follow}.include?(a)
  return nil
end

def get_branch
  ARGV[1].downcase
end

def get_origin
  return ARGV[2] if ARGV.size > 2 
  return "origin"
end

def read_params
  p={}
  begin
    p[:action] = get_action
    p[:branch] = get_branch
    p[:origin] = get_origin
    p[:current_branch] = get_current_branch
    p
  rescue
    {:action=>:help}
  end
end
