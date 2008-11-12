module ShouldaFunctionalHelpers
  include CaptureFu
  include InDir
  
  def self.ruby_prefix
    if ENV['RUBY']
      warn "  Forcing execution of grb with ruby interpreter #{ENV['RUBY']}"
      ENV['RUBY'] + ' '
    elsif WINDOWS
      'ruby '
    else
      ''
    end
  end
  
  # Here we're only prepending with 'ruby'. 
  # When run as a gem, RubyGems takes care of generating a batch file that does this stuff.
  GRB_COMMAND = ruby_prefix + File.expand_path(File.dirname(__FILE__) + '/../../bin/grb') unless defined?(GRB_COMMAND)
  
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
    
    def in_branch(branch)
      execute "git checkout #{branch}"
    end
    
    
    def run_grb_with(params='')
      execute "#{GRB_COMMAND} #{params}"
    end

    def execute(command)
      in_dir current_dir do
        errno, returned_string = capture_process_output(command)
        returned_string
      end
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
    def should_have_branch(what_branch, *wheres)
      wheres.flatten.each do |where|
        should "have the branch '#{what_branch}' #{where == :local ? 'locally' : 'remotely'}" do
          args = get_branch_location(where)
          assert_match(/#{what_branch}/, execute("git branch #{args}"))
        end
      end
    end
    
    def should_not_have_branch(what_branch, *wheres)
      wheres.flatten.each do |where|
        should "not have the branch '#{what_branch}' #{where == :local ? 'locally' : 'remotely'}" do
          args = get_branch_location(where)
          assert_no_match(/#{what_branch}/, execute("git branch #{args}"))
        end
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
    
    def in_a_non_git_directory
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
