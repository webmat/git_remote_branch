module ShouldaFunctionalHelpers
  include CaptureFu
  GRB_COMMAND = File.expand_path(File.dirname(__FILE__) + '/../../bin/grb') unless defined?(GRB_COMMAND)
  
  def self.included(base)
    base.extend  ClassMethods
    base.class_eval do
      include ::ShouldaFunctionalHelpers::InstanceMethods
    end
  end
  
  module InstanceMethods
    def current_dir
      @current_dir || raise("@current_dir is not set. Warning, Will Robinson!")
    end
    
    def current_dir=(value)
      @current_dir = value
    end
    
    # Switches to one of the directories created by GitHelper:
    #   :local1, :local2, :non_git or :remote
    # This affects commands run with ``, system and so on.
    def in_directory_for(dir)
      # Just a reminder for my dumb head
      raise "'in_directory_for' depends on @gh being set" unless @gh
      
      @current_dir = eval("@gh.#{dir}")
    end
    
    
    def run_with(params='')
      silencer = (params =~ /--silent/) ? '' : '--silent'
      execute "#{GRB_COMMAND} #{params} #{silencer}"
    end

    def execute(command)
      errno, returned_string = capture_process_output("cd #{current_dir} ; #{command}")
      returned_string
    end
    
    private
      def get_branch_location(location)
        case location.to_sym
        when :local
          args = '-l'
        when :remote
          args = '-r'
        else
          raise ArgumentError, "Unknown branch location: #{location.inspect}"
        end
      end
  end

  module ClassMethods
    def should_have_branch(what_branch, where)
      should "have the branch '#{what_branch}' #{where == :local ? 'locally' : 'remotely'}" do
        args = get_branch_location(where)
        assert_match(/#{what_branch}/, execute("git branch #{args}"))
      end
    end
    
    def should_not_have_branch(what_branch, where)
      should "not have the branch '#{what_branch}' #{where == :local ? 'locally' : 'remotely'}" do
        args = get_branch_location(where)
        assert_no_match(/#{what_branch}/, execute("git branch #{args}"))
      end
    end
    
    def on_a_repository
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
    
    def in_non_git_directory
      context "on a non-git related directory" do
        setup do
          @temp_dir = TempDirHelper.new
          @current_dir = @temp_dir.directory
        end
        
        teardown do
          @temp_dir.cleanup
        end

        yield
      end
    end
  end
end
