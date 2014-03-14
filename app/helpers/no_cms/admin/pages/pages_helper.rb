module NoCms::Admin::Pages
  module PagesHelper

    def page_listing_item_classes page, current_page
      classes = []
      classes << 'current' if current_page == page
      classes << 'oculto' if page.draft
      classes
    end

    def block_form_classes block
      classes = []
      classes << 'oculto' if block.draft
      classes << 'new' if block.new_record?
      classes
    end

    def block_form_id block
      block.new_record? ?
      "new_content_block_#{block.layout}" :
      "content_block_#{block.id}"
    end

  end
end
