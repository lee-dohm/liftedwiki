# 
# Copyright (c) 2012 by Lifted Studios.  All Rights Reserved.
# 

gem 'minitest'

require 'minitest/spec'
require 'minitest/autorun'

require 'liftedwiki'

describe LiftedWiki::ReferenceFilter do
  it 'can be instantiated' do
    filter = LiftedWiki::ReferenceFilter.new('Some fake document text')

    filter.wont_be_nil
  end
end
