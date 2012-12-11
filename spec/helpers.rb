# 
# Copyright (c) 2012 by Lifted Studios.  All Rights Reserved.
# 

# Reads a test data file.
# 
# The path passed to the function is treated as relative to the
# liftedwiki/spec/data directory.
# 
# @param path Path to the test file.
# @return Text in the file.
def read_test_file(path)
  path = File.join('spec/data', path)
  IO.read(path)
end
