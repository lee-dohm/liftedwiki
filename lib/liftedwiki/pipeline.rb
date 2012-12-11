# 
# Copyright (c) 2012 by Lifted Studios.  All Rights Reserved.
# 

require 'html/pipeline'

module LiftedWiki
  # Defines the standard Lifted Wiki Markdown-to-HTML pipeline.
  class Pipeline
    # Initializes a new intstance of the pipeline.
    def initialize
      @pipeline = HTML::Pipeline.new [ HTML::Pipeline::MarkdownFilter ]
    end

    # Executes the pipeline on the supplied text.
    # 
    # @param text Text to run through the pipeline.
    # @return HTML that results from the pipeline.
    def run(text)
      @pipeline.call(text)[:output]
    end
  end
end
