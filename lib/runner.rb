module GitRemoteBranch
  class Runner
    attr_reader :echo, :silent, :colorize
    def initialize(options={})
      @echo	= !!options[:echo]
      @silent	= !!options[:silent]
      @colorize = !!options[:colorize]
      @silencer = silent ? ' 2>&1' : ''
    end

    def run(cmd)
      whisper(colorize ? cmd.red : cmd)
      capture_process_output cmd + @silencer
    end
  end
end

