class String
  def path_for_os
  	WINDOWS ? self.gsub('/', '\\') : self
  end
end
