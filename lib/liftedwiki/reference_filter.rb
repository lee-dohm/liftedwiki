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
  # `<references/>` is placed in the text, an ordered list of the references and their text will be placed at that
  # location.
  class ReferenceFilter < HTML::Pipeline::Filter
    # Replaces references with the appropriate HTML and returns the result.
    def call
      refs = []

      doc.xpath('.//ref').each do |ref_node|
        refs << ref_node.inner_html

        sup_node = ref_node.document.create_element('sup', :class => 'reference', :id => "wiki-cite_ref-#{refs.count}")
        sup_node.inner_html = "[<a href=\"#wiki-cite_note-#{refs.count}\">#{refs.count}</a>]"

        ref_node.replace(sup_node)
      end

      set = doc.xpath('.//references')
      if set
        inner_html = ""
        refs.each_with_index do |note, i|
          num = i + 1
          inner_html << "<li id=\"wiki-cite_note-#{num}\"><b><a href=\"#wiki-cite_ref-#{num}\">^</a></b> #{note}</li>"
        end

        set.each do |references_node|
          ol_node = references_node.document.create_element "ol"
          ol_node.inner_html = inner_html
          references_node.replace ol_node
        end
      end

      doc
    end
  end
end
