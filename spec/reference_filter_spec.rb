# 
# Copyright (c) 2012 by Lifted Studios.  All Rights Reserved.
# 

gem 'minitest'

require 'minitest/spec'
require 'minitest/autorun'

require 'html/pipeline'
require 'nokogiri'
require 'liftedwiki'

describe LiftedWiki::ReferenceFilter do
  def new_pipeline
    HTML::Pipeline.new([ HTML::Pipeline::MarkdownFilter ])
  end

  def new_filter(fragment)
    if fragment.kind_of? String
      pipeline = new_pipeline
      fragment = pipeline.call(fragment)[:output].to_s
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

    text.must_equal '<p>Some fake document text</p>'
  end

  it 'will replace refs with footnote anchors' do
    filter = new_filter(read_test_file('simple_reference.md'))

    text = filter.call.to_s

    text.node('ref').count.must_equal 0
    text.node('sup').count.must_equal 1
    text.node('sup').attribute('class').value.must_equal 'reference'
    text.node('sup').attribute('id').value.must_equal 'wiki-cite_ref-1'
    text.node('sup').inner_html.must_equal '[<a href="#wiki-cite_note-1">1</a>]'
  end

  it 'will replace references with the ordered list of footnotes' do
    filter = new_filter(read_test_file('full_reference.md'))

    text = filter.call.to_s

    text.node('references').count.must_equal 0
    text.node('ol').count.must_equal 1
  end
end
