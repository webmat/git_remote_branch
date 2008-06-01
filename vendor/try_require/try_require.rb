# This is a very early version of try_require. 
# See github.com/webmat/try_require for more info.
def try_require(what, &block)
  loaded, require_result = false, nil 

  begin
    require_result = require what
    loaded = true 

  rescue LoadError => ex
    puts "Unable to require '#{what}'", "#{ex.class}: #{ex.message}"
  end 

  yield if loaded and block_given? 

  require_result
end

