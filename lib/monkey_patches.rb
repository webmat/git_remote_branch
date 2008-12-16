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
  def path_for_os
    WINDOWS ? self.gsub('/', '\\') : self
  end
end

