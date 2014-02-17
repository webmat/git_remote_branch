# One nice thing about command-line tools is that nobody cares how 
# much you monkey-patch :-)

module Kernel
  def whisper(*msgs)
    unless $WHISPER
      puts *msgs
    end
  end
end

class String
  def red
    return self if WINDOWS
    "\e[31m#{self}\e[0m"
  end

  def path_for_os
    WINDOWS ? self.gsub('/', '\\') : self
  end
end
