# 
# Copyright (c) 2012 by Lifted Studios.  All Rights Reserved.
# 

gem 'minitest'

require 'minitest/spec'
require 'minitest/autorun'

require 'liftedwiki'

describe 'Version' do
  it 'will have a version' do
    LiftedWiki::VERSION.kind_of?(String).must_equal true
    LiftedWiki::VERSION.must_match(/\d+\.\d+\.\d+/)
  end
end
