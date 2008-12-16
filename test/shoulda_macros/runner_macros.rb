module RunnerMacros
  def self.running(cmd_or_msg, cmd = nil, &block)
    unless cmd
      cmd = cmd_or_msg
      msg = cmd.inspect
    else
      msg = cmd_or_msg
    end

    context "running #{msg}" do
      setup do
	@return, @output = @runner.run(cmd)
      end
      context '' do
	yield
      end
    end
  end

  def self.should_return(n)
    should "return #{n}" do
      assert_equal n, @return
    end
  end

  def self.should_output(s)
    should "output #{s.inspect}" do
      assert_match s, @output
    end
  end

  def self.should_not_output
    should "output nothing" do
      assert_equal '', @output
    end
  end
end

