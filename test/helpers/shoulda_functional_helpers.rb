module ShouldaFunctionalHelpers
  def self.included(base)
    base.extend  ClassMethods
    base.class_eval do
      include ::ShouldaFunctionalHelpers::InstanceMethods
    end
  end
  
  module InstanceMethods
    def run_with(params='')
      execute "grb #{params}"
    end

    def execute(command)
      raise "'execute' depends on @dir being set" unless @dir
      `#{command}`
    end
    
    
    def assert_branch(branch_name, branch_location)
      case branch_location.to_sym
      when :local
        args = ''
      when :remote
        args = '-r'
      else
        raise ArgumentError, "Unknown branch location: #{branch_location.inspect}"
      end
      
      assert_match %r{#{branch_name}}, execute("git branch #{args}")
    end
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
    #   :local1, :local2, :non_git or :remote
    # This affects commands run with ``, system and so on.
    def in_directory_for(dir)
      context "in directory for #{dir}" do
        setup do
          # Just a reminder for my dumb head
          raise "'in_directory_for' depends on @gh being set" unless @gh

          Dir.pushd eval("@gh.#{dir}")
        end
        
        teardown do
          Dir.popd
        end
        
        yield
      end
    end
  end
end
