# 
# Copyright (c) 2012 by Lifted Studios.  All Rights Reserved.
# 

gem 'minitest'

require 'minitest/spec'
require 'minitest/autorun'

require 'liftedwiki'

describe LiftedWiki::WikiLinkFilter do
  it 'can be instantiated' do
    filter = LiftedWiki::WikiLinkFilter.new('Just some sample text')

    filter.wont_be_nil
  end
end