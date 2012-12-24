# 
# Copyright (c) 2012 by Lifted Studios.  All Rights Reserved.
# 

module LiftedWiki
  # An `HTML::Pipeline` filter class that detects wiki-style links and converts them to HTML links.
  class WikiLinkFilter < HTML::Pipeline::Filter
    def initialize(text)
      raise ArgumentError, "WikiLinkFilter only supports raw text." unless text.kind_of? String
    end
  end
end
