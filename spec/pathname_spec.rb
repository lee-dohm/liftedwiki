# 
# Copyright (c) 2012 by Lifted Studios.  All Rights Reserved.
# 

gem 'minitest'

require 'minitest/spec'
require 'minitest/autorun'

require 'liftedwiki'

describe Pathname do
  it 'will have a to_display method' do
    path = Pathname.new('foo_bar_baz')

    path = path.to_display

    path.kind_of?(Pathname).must_equal true
    path.to_s.must_equal 'foo bar baz'
  end

  it 'will not change the path of the file when to_display is called' do
    path = Pathname.new('foo_bar/baz')

    path = path.to_display

    path.kind_of?(Pathname).must_equal true
    path.to_s.must_equal 'foo_bar/baz'
  end

  it 'will have a to_source method' do
    path = Pathname.new('foo bar baz')

    path = path.to_source

    path.kind_of?(Pathname).must_equal true
    path.to_s.must_equal 'foo_bar_baz'
  end

  it 'will not change the path of the file when to_source is called' do
    path = Pathname.new('foo bar/baz')

    path = path.to_source

    path.kind_of?(Pathname).must_equal true
    path.to_s.must_equal 'foo bar/baz'
  end
end
