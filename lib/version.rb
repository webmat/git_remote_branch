module GitRemoteBranch
  module VERSION #:nodoc:
    MAJOR    = 0
    MINOR    = 3
    TINY     = 4

    STRING   = [MAJOR, MINOR, TINY].join('.')
  end

  NAME          = 'git_remote_branch'
  COMPLETE_NAME = "#{NAME} #{VERSION::STRING}"
  COMMAND_NAME  = 'grb'
  SHORT_NAME    = COMMAND_NAME
end
