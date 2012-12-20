# 
# Copyright (c) 2012 by Lifted Studios.  All Rights Reserved.
# 

class Pathname
  # Converts the filename for display by replacing underscores in the filename (not the path) with spaces.
  # 
  # @return [Pathname] Path with any underscores replaced with spaces.
  def to_display
    dir = dirname
    file = basename.to_s.gsub(/_/, ' ')
    Pathname.new(dir) + file
  end
end
