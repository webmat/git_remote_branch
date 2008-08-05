module CaptureFu
  VERSION = '0.0.1'

  def capture_output(&block)
    real_out, real_err = $stdout, $stderr
    result = fake_out = fake_err = nil
    begin
      fake_out, fake_err = Helpers::PipeStealer.new, Helpers::PipeStealer.new
      $stdout, $stderr = fake_out, fake_err
      result = yield
    ensure
      $stdout, $stderr = real_out, real_err
    end
    return result, fake_out.captured, fake_err.captured
  end

  # This first implementation is only intended for batch executions.
  # You can't pipe stuff programmatically to the child process.
  def capture_process_output(command)

    #capture stderr in the same stream
    command << ' 2>&1' unless Helpers.stderr_already_redirected(command)

    out = `#{command}`
    return $?.exitstatus, out
  end


  private

  module Helpers
    
    def self.stderr_already_redirected(command)
      #Already redirected to stdout (valid for Windows)
      return true if command =~ /2>&1\s*\Z/

      #Redirected to /dev/null (this is clearly POSIX-dependent)
      return true if command =~ /2>\/dev\/null\s*\Z/

      return false
    end

    class PipeStealer < File
      attr_reader :captured
      def initialize
        @captured = ''
      end
      def write(s)
        @captured << s
      end
      def captured
        return nil if @captured.empty?
        @captured.dup
      end
    end

  end #Helper module
end
