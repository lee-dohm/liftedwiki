# 
# Copyright (c) 2012 by Lifted Studios.  All Rights Reserved.
# 

gem 'minitest'

require 'minitest/spec'
require 'minitest/autorun'

require 'helpers'
require 'liftedwiki'

describe LiftedWiki::Pipeline do
  def new_pipeline
    LiftedWiki::Pipeline.new
  end

  it 'can be instantiated' do
    pipeline = new_pipeline

    pipeline.wont_be_nil
  end

  it 'can convert Markdown to HTML' do
    pipeline = new_pipeline
    markdown = read_test_file('test.md')

    html = pipeline.run(markdown)

    html.must_match(/<h1>Level One<\/h1>/)
    html.must_match(/<h2>Level Two<\/h2>/)
    html.must_match(/<h3>Level Three<\/h3>/)
    html.must_match(/<p>Some text.<\/p>/)
    html.must_match(/<p>Some more text.<\/p>/)
    html.must_match(/<p>Still more text.<\/p>/)
  end

  it 'can syntax highlight code' do
    pipeline = new_pipeline
    code = read_test_file('code.md')

    html = pipeline.run(code)

    html.must_match(/<pre lang="ruby"><code>/)
    html.must_match(/<\/code><\/pre>/)
  end
end