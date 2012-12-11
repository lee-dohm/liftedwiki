# 
# Copyright (c) 2012 by Lifted Studios.  All Rights Reserved.
# 

gem 'minitest'

require 'minitest/spec'
require 'minitest/autorun'

require 'liftedwiki'

describe LiftedWiki::Pipeline do
  def new_pipeline
    LiftedWiki::Pipeline.new
  end

  it 'can be instantiated' do
    pipeline = new_pipeline

    pipeline.wont_be_nil
  end
end