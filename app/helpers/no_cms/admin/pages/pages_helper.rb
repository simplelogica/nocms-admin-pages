module NoCms::Admin::Pages
  module PagesHelper
    def page_listing_item_classes page, current_page
      classes = []
      classes << 'current' if current_page == page
      classes << 'oculto' if page.draft
      classes
    end
  end
end
