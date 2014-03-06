require 'spec_helper'

describe NoCms::Admin::Pages do

  context "when editing a page" do

    let(:nocms_page) { create :nocms_page }
    let(:page_title) { Faker::Lorem.sentence }

    subject { page }

    before do
      visit no_cms_admin_pages.edit_page_path(nocms_page)

      fill_in I18n.t('activerecord.attributes.no_cms/pages/page.title'), with: page_title

      click_button(I18n.t('no_cms.admin.pages.pages.new.submit'))
    end

    it "should show the page in the admin index" do
      expect(current_path).to eq no_cms_admin_pages.pages_path
      expect(subject).to have_selector 'li', text: page_title
    end

  end
end
