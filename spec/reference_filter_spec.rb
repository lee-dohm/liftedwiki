# 
# Copyright (c) 2012 by Lifted Studios.  All Rights Reserved.
# 

gem 'minitest'

require 'minitest/spec'
require 'minitest/autorun'

require 'nokogiri'
require 'liftedwiki'

describe LiftedWiki::ReferenceFilter do
  def new_filter(fragment)
    case fragment
    when String
      fragment = Nokogiri.make(fragment)
    end

    LiftedWiki::ReferenceFilter.new(fragment)
  end

  it 'can be instantiated' do
    filter = new_filter('Some fake document text')

    filter.wont_be_nil
  end

  it 'will pass through a fragment without references unchanged' do
    filter = new_filter('Some fake document text')

    text = filter.call.to_s

    text.must_equal 'Some fake document text'
  end

  it 'will replace references with footnote anchors' do
    filter = new_filter(read_test_file('simple_reference.html'))

    text = filter.call.to_s

    text.must_match(/<sup class="reference">\[<a href="#wiki-cite_note-1">1<\/a>\]<\/sup>/)
  end
end
