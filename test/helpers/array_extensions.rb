# Can be included in any class that responds to #each. 
# Such as Array.
module CountDistinct
  def count_all(purge_smaller_than=0)
    h={}
    self.each {|e|
      h[e] ? h[e] += 1 : h[e] = 1
    }
    h.extract{|k,v| v >= purge_smaller_than}
  end
end

Array.send :include, CountDistinct

