# 
# Copyright (c) 2012 by Lifted Studios.  All Rights Reserved.
# 

require 'html/pipeline'

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
    # ID of the note
    NOTE = 'wiki-cite_note'

    # ID of the ref
    REF = 'wiki-cite_ref'

    # Replaces ref and references tags with the appropriate HTML and returns the result.
    def call
      refs = replace_refs
      replace_references(refs)

      doc
    end

    private

    # Creates the HTML to replace the ref node in the document.
    # 
    # @param [Nokogiri::XML::Node] node  Node in the document we are working with.
    # @param [Integer]             index Index of the item.
    def create_ref_node(node, index)
      ref_node = node.document.create_element('sup', :class => 'reference', :id => "#{REF}-#{index}")
      ref_node.inner_html = %Q([<a href="##{NOTE}-#{index}">#{index}</a>])
      ref_node
    end

    # Replaces ref tags with the appropriate HTML and returns the set of reference texts.
    def replace_refs
      doc.xpath('.//ref').each_with_index.map do |node, index|
        text = node.inner_html

        ref_node = create_ref_node(node, index + 1)
        node.replace(ref_node)

        text
      end
    end

    # Replaces references tags with the appropriate HTML.
    # 
    # @param [Array] refs List of reference texts.
    def replace_references(refs)
      set = doc.xpath('.//references')
      if set
        inner_html = ''
        refs.each_with_index do |note, i|
          num = i + 1
          inner_html << %Q(<li id="#{NOTE}-#{num}"><b><a href="##{REF}-#{num}">^</a></b> #{note}</li>)
        end

        set.each do |references_node|
          ol_node = references_node.document.create_element "ol"
          ol_node.inner_html = inner_html
          references_node.parent.replace(ol_node)
        end
      end
    end
  end
end
