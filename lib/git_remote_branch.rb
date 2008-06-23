$LOAD_PATH.unshift( File.dirname(__FILE__) )
require 'param_reader'

module GitRemoteBranch
  VERSION = '0.2.1'

  COMMANDS = {
    :create     => {
      :description => 'create a new remote branch and track it locally',
      :aliases  => %w{create new},
      :commands => [
        '"git push #{origin} #{current_branch}:refs/heads/#{branch_name}"',
        '"git fetch #{origin}"',
        '"git branch --track #{branch_name} #{origin}/#{branch_name}"',
        '"git checkout #{branch_name}"'
      ]
    },

    :delete     => {
      :description => 'delete a local and a remote branch',
      :aliases  => %w{delete destroy kill remove},
      :commands => [
        '"git push #{origin} :refs/heads/#{branch_name}"',
        '"git checkout master" if current_branch == branch_name',
        '"git branch -d #{branch_name}"'
      ]
    },

    :track      => {
      :description => 'track an existing remote branch',
      :aliases  => %w{track follow grab fetch},
      :commands => [
        '"git fetch #{origin}"',
        '"git checkout master" if current_branch == branch_name',
        '"git branch --track #{branch_name} #{origin}/#{branch_name}"'
      ]
    }
  }

  def print_welcome
    puts "git_remote_branch version #{VERSION}", '-' * 70, ''
  end

  def print_usage
    puts <<-HELP
  Usage:

  grb create branch_name [origin_server]

  grb delete branch_name [origin_server]

  grb track branch_name [origin_server]

  If origin_server is not specified, the name 'origin' is assumed (git's default)
  
  All commands also have aliases:
  #{ COMMANDS.keys.map{|k| k.to_s}.sort.map {|cmd| 
    "#{cmd}: #{COMMANDS[cmd.to_sym][:aliases].join(', ')}" }.join("\n  ") }
  HELP
  end

  def execute_action(action, branch_name, origin, current_branch)
    cmds = COMMANDS[action][:commands].map{ |c| eval(c) }.compact
    execute_cmds(cmds)
  end

  def explain_action(action, branch_name, origin, current_branch)
    cmds = COMMANDS[action][:commands].map{ |c| eval(c) }.compact
    
    puts "List of operations to do to #{COMMANDS[action][:description]}:", ''
    puts_cmd cmds
    puts ''
  end

  def execute_cmds(*cmds)
    cmds.flatten.each do |c|
      puts_cmd c
      `#{c}`
      puts ''
    end
  end

  def puts_cmd(*cmds)
    cmds.flatten.each do |c|
      puts "#{c}"
    end
  end
end
