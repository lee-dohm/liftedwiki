# 
# Copyright (c) 2012 by Lifted Studios.  All Rights Reserved.
# 

gem 'minitest'

require 'minitest/spec'
require 'minitest/autorun'

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

  it 'raises an error if given a Nokogiri DocumentFragment' do
    proc {
      new_filter(Nokogiri::make('Just some sample text'))
    }.must_raise ArgumentError
  end
end