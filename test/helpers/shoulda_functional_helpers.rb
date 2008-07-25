module ShouldaFunctionalHelpers
  def self.included(base)
    base.extend( ClassMethods )
  end

  module ClassMethods
    def on_a_new_repo
      context "on a new repository" do
        setup do
          @gh = GitHelper.new
        end

        teardown do
          @gh.cleanup
        end

        yield
      end
    end
    
    # Switches to one of the directories created by GitHelper:
    # => :local1
    # => :local2
    # => :non_git
    # => :remote
    # This affects commands run with ``, system and so on.
    def in_directory_for(dir)
      context "in directory for #{dir}" do
        setup do
          # Just a reminder for my dumb head
          raise "'in_directory_for' must be nested inside a 'on_a_new_repo'" unless @gh

          Dir.chdir eval("@gh.#{dir}")
        end
        
        yield
      end
    end
  end
end
