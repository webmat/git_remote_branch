require 'rubygems'
require 'ruby-debug'

module GitRemoteBranch
  VERSION = '0.2.1'

  COMMANDS = {
    :create     => {
      :aliases  => %w{create new},
      :commands => [
        '"git push origin #{current_branch}:refs/heads/#{branch_name}"',
        '"git fetch #{origin}"',
        '"git branch --track #{branch_name} #{origin}/#{branch_name}"',
        '"git checkout #{branch_name}"'
      ]
    },

    :delete     => {
      :aliases  => %w{delete destroy kill remove},
      :commands => [
        '"git push #{origin} :refs/heads/#{branch_name}"',
        '"git checkout master" if current_branch == branch_name',
        '"git branch -d #{branch_name}"'
      ]
    },

    :track      => {
      :aliases  => %w{track follow grab fetch},
      :commands => [
        '"git fetch #{origin}"',
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

  def execute_cmds(*cmds)
    cmds.flatten.each do |c|
      puts "Executing: #{c}"
      `#{c}`
      puts ""
    end
  end

  def create(branch_name, origin, current_branch)
    cmds = COMMANDS[:create][:commands].map{|c| eval(c) }
    execute_cmds(cmds)
  end

  def delete(branch_name, origin, current_branch)
    cmds = COMMANDS[:delete][:commands].map{|c| eval(c) }
    execute_cmds(cmds)
  end

  def track(branch_name, origin)
    cmds = COMMANDS[:track][:commands].map{|c| eval(c) }
    execute_cmds(cmds)
  end

  def get_current_branch
    x = `git branch -l`
    x.each_line do |l|
      return l.sub("*","").strip if l =~ /\A\*/
    end

    puts "Couldn't identify the current local branch."
    return nil
  end

  def get_action
    a = ARGV[0].downcase
    return :create if COMMANDS[:create][:aliases].include?(a)
    return :delete if COMMANDS[:delete][:aliases].include?(a)
    return :track  if COMMANDS[:track][:aliases].include?(a)
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
    p[:action] = get_action
    p[:branch] = get_branch
    p[:origin] = get_origin
    p[:current_branch] = get_current_branch
    p
    rescue
      puts "Invalid parameters"
      {:action=>:help}
  end
end
