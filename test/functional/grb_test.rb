require File.join( File.dirname(__FILE__), '..', 'test_helper')

class GRBTest < Test::Unit::TestCase
  include ShouldaFunctionalHelpers
  
  on_a_new_repo do
    should "@gh be set" do
      assert @gh
      puts @gh.inspect
    end
    
    in_directory_for :local1 do
      puts Dir.pwd
    end
  end
end
