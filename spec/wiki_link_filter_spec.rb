# 
# Copyright (c) 2012 by Lifted Studios.  All Rights Reserved.
# 

gem 'minitest'

require 'minitest/spec'
require 'minitest/autorun'

require 'helpers'
require 'liftedwiki'
require 'nokogiri'

describe LiftedWiki::WikiLinkFilter do
  # Creates a new `WikiLinkFilter` object.
  # 
  # @param text Text for the filter to parse.
  # @return [LiftedWiki::WikiLinkFilter] Newly created filter object.
  def new_filter(text)
    LiftedWiki::WikiLinkFilter.new(text)
  end

  it 'can be instantiated' do
    filter = new_filter('Just some sample text')

    filter.wont_be_nil
  end

  it 'converts a normal wiki link' do
    filter = new_filter('[[Link]]')

    text = filter.call

    text.must_equal '<a href="/Link">Link</a>'
  end

  it 'converts a wiki link with a description' do
    filter = new_filter('[[Link|Description]]')

    text = filter.call

    text.must_equal '<a href="/Link">Description</a>'
  end
end