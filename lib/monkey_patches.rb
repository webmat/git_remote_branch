# One nice thing about command-line tools is that nobody cares how 
# much you monkey-patch :-)

module Kernel
  def whisper(*msgs)
    unless $WHISPER
      # msgs.flatten ?  msgs.flatten.each{|m| puts m} : puts
      puts *msgs
    end
  end
end

