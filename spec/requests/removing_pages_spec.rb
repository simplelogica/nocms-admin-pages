require 'spec_helper'

describe NoCms::Admin::Pages do

  context "when removing a page", js: true do

    let(:nocms_page) { create :nocms_page }

    subject { page }

    before do

      nocms_page.path # If we don't load the path it's destroyed before we ever access it and then we are unable to access the page

      visit no_cms_admin_pages.pages_path

      click_button I18n.t('no_cms.admin.pages.pages.page_listing_item.destroy')
    end

    it "should not show the page in the admin index" do
      expect(current_path).to eq no_cms_admin_pages.pages_path
      expect(subject).to_not have_selector 'li', text: nocms_page.title
    end

    it "page should not be accessible" do
      visit nocms_page.path
      expect(subject.status_code).to eq 404
    end

  end
end
