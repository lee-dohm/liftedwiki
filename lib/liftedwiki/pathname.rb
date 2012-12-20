# 
# Copyright (c) 2012 by Lifted Studios.  All Rights Reserved.
# 

# Extensions to the standard Ruby library `Pathname` class for use in converting wiki filenames
# to and from their display and storage representations.
class Pathname
  # Converts the filename for display by replacing underscores in the filename (not the path) with spaces.
  # 
  # @return [Pathname] Path with any underscores replaced with spaces.
  def to_display
    dir = dirname
    ext = extname
    file = basename(ext).to_s.gsub(/_/, ' ')
    Pathname.new(dir) + file
  end

  # Converts the filename for saving to storage by replacing spaces in the filename (not the path) with underscores.
  # 
  # @param [String] ext Extension to add to the filename, if any.
  # @return [Pathname] Path with any spaces replaced with underscores.
  def to_source(ext = nil)
    dir = dirname
    file = basename.to_s.gsub(/ /, '_')
    file += ".#{ext}" if ext
    Pathname.new(dir) + file
  end
end
