# 
# Copyright (c) 2012-2013 by Lifted Studios.  All Rights Reserved.
# 

require 'html/pipeline'
require 'html/pipeline/cite'
require 'liftedwiki/wiki_link_filter'

module LiftedWiki
  # Defines the standard Lifted Wiki Markdown-to-HTML pipeline.
  # 
  # The standard pipeline supports converting [Markdown](http://daringfireball.net/projects/markdown/syntax) into HTML along with
  # syntax highlighting of code blocks, footnotes and [emoji](http://www.emoji-cheat-sheet.com/).
  class Pipeline
    # Standard pipeline definition
    PIPELINE = [
      LiftedWiki::WikiLinkFilter,
      HTML::Pipeline::MarkdownFilter,
      HTML::Pipeline::EmojiFilter,
      HTML::Pipeline::CiteFilter,
      HTML::Pipeline::SyntaxHighlightFilter
    ]

    # Initializes a new intstance of the pipeline.
    def initialize
      @context = { :asset_root => '/images' }
      @pipeline = HTML::Pipeline.new(PIPELINE, @context)
    end

    # Executes the pipeline on the supplied text.
    # 
    # @param text Text to run through the pipeline.
    # @return HTML fragment that results from the pipeline.
    def run(text)
      @pipeline.call(text)[:output].to_s
    end
  end
end
