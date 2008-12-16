require File.join( File.dirname(__FILE__), '..', 'test_helper')

class RunnerTest < Test::Unit::TestCase
  context "parameters, when instantiating a runner" do
    context "with no parameters" do
      setup do
	@runner = GitRemoteBranch::Runner.new
      end
      should "default to normal ` or Kernel#system behavior" do
	assert !@runner.echo, 'not echo'
	assert !@runner.silent, 'not silence the output'
	assert !@runner.colorize, 'not colorize'
      end
    end

    context "with parameters" do
      setup do
	@runner = GitRemoteBranch::Runner.new(:silent => true, :echo => true, :colorize => true)
      end	

      should "take them into account" do
	assert @runner.echo, 'echo'
	assert @runner.silent, 'silence output'
	assert @runner.colorize, 'colorize'
      end
    end
  end
end

