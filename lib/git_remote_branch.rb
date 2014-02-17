begin
  WINDOWS = !!(RUBY_PLATFORM =~ /win32|cygwin/)
rescue Exception
end

grb_app_root = File.expand_path( File.dirname(__FILE__) + '/..' )

$LOAD_PATH.unshift( grb_app_root + '/vendor' )
require 'capture_fu'

$LOAD_PATH.unshift( grb_app_root + '/lib' )
%w(monkey_patches constants  state param_reader version).each do |f|
  require f
end

module GitRemoteBranch
  class InvalidBranchError < RuntimeError; end
  class NotOnGitRepositoryError < RuntimeError; end

  COMMANDS = {
    :create     => {
      :description => 'create a new remote branch and track it locally',
      :aliases  => %w{create new},
      :commands => [
        '"#{GIT} push #{origin} #{current_branch}:refs/heads/#{branch_name}"',
        '"#{GIT} fetch #{origin}"',
        '"#{GIT} branch --track #{branch_name} #{origin}/#{branch_name}"',
        '"#{GIT} checkout #{branch_name}"'
      ]
    },

    :publish     => {
      :description => 'publish an existing local branch',
      :aliases  => %w{publish remotize share},
      :commands => [
        '"#{GIT} push #{origin} #{branch_name}:refs/heads/#{branch_name}"',
        '"#{GIT} fetch #{origin}"',
        '"#{GIT} branch -u #{origin}/#{branch_name} #{branch_name}"',
        '"#{GIT} checkout #{branch_name}"'
      ]
    },

    :rename     => {
      :description => 'rename a remote branch and its local tracking branch',
      :aliases  => %w{rename rn mv move},
      :commands => [
        '"#{GIT} push #{origin} #{current_branch}:refs/heads/#{branch_name}"',
        '"#{GIT} fetch #{origin}"',
        '"#{GIT} branch --track #{branch_name} #{origin}/#{branch_name}"',
        '"#{GIT} checkout #{branch_name}"',
        '"#{GIT} push #{origin} :refs/heads/#{current_branch}"',
        '"#{GIT} branch -d #{current_branch}"',
      ]
    },

    :delete     => {
      :description => 'delete a local and a remote branch',
      :aliases  => %w{delete destroy kill remove rm},
      :commands => [
        '"#{GIT} push #{origin} :refs/heads/#{branch_name}"',
        '"#{GIT} checkout master" if current_branch == branch_name',
        '"#{GIT} branch -d #{branch_name}"'
      ]
    },

    :track      => {
      :description => 'track an existing remote branch',
      :aliases  => %w{track follow grab fetch},
      :commands => [
        '"#{GIT} fetch #{origin}"',
        '"#{GIT} branch --track #{branch_name} #{origin}/#{branch_name}"',
      ]
    }
  } unless defined?(COMMANDS)

  def self.get_reverse_map(commands)
    h={}
    commands.each_pair do |cmd, params|
      params[:aliases].each do |alias_|
        unless h[alias_]
          h[alias_] = cmd
        else
          raise "Duplicate aliases: #{alias_.inspect} already defined for command #{h[alias_].inspect}"
        end
      end
    end
    h
  end
  ALIAS_REVERSE_MAP = get_reverse_map(COMMANDS) unless defined?(ALIAS_REVERSE_MAP)

  def get_welcome
    "git_remote_branch version #{VERSION::STRING}\n\n"
  end

  def get_usage
    return <<-HELP
  Usage:

#{[:create, :publish, :rename, :delete, :track].map{|action|
      "  grb #{action} branch_name [origin_server]"
    } * "\n"
  }

  Notes:
  - If origin_server is not specified, the name 'origin' is assumed (git's default)
  - The rename functionality renames the current branch

  The explain meta-command: you can also prepend any command with the keyword 'explain'. Instead of executing the command, git_remote_branch will simply output the list of commands you need to run to accomplish that goal.
  Example:
    grb explain create
    grb explain create my_branch github

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

    whisper "List of operations to do to #{COMMANDS[action][:description]}:", ''
    puts_cmd cmds
    whisper ''
  end

  def execute_cmds(*cmds)
    silencer = $WHISPER ? ' 2>&1' : ''
    cmds.flatten.each do |c|
      puts_cmd c
      `#{c}#{silencer}`
      whisper ''
    end
  end

  def puts_cmd(*cmds)
    cmds.flatten.each do |c|
      whisper "#{c}".red
    end
  end
end
