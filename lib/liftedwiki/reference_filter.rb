# 
# Copyright (c) 2012 by Lifted Studios.  All Rights Reserved.
# 

module LiftedWiki
  # An `HTML::Pipeline` filter that collects references in the text and inserts a table of footnotes where instructed.
  # 
  # Example:
  # 
  #     <ref>This is a footnote</ref>
  # 
  # Will show up as a bracketed, superscripted and anchored number at that location in the text.  Then when 
  # `<references/>` is placed in the text an ordered list of the references and their text will be placed at that
  # location.
  class ReferenceFilter < HTML::Pipeline::Filter
  end
end
