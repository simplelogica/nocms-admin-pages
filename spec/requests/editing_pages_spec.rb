require 'spec_helper'

describe NoCms::Admin::Pages do

  context "when editing a page" do

    let(:nocms_page) { create :nocms_page }
    let(:block_default_layout) { create :nocms_block, layout: 'default', page: nocms_page, title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph }
    let(:page_title) { Faker::Lorem.sentence }
    let(:block_title) { Faker::Lorem.sentence }

    subject { page }

    before do

      block_default_layout

      visit no_cms_admin_pages.edit_page_path(nocms_page)

      within('#content_fields') do
        fill_in I18n.t('activerecord.attributes.no_cms/pages/page.title'), with: page_title
      end

      within("#content_block_#{block_default_layout.id}") do
        fill_in I18n.t('activerecord.attributes.no_cms/pages/page.title'), with: block_title
      end

      click_button(I18n.t('no_cms.admin.pages.pages.new.submit'))
    end

    it "should show the page in the admin index" do
      expect(current_path).to eq no_cms_admin_pages.pages_path
      expect(subject).to have_selector 'li', text: page_title
    end

    it "should show the edited contents" do
      visit nocms_page.path
      expect(page).to have_selector('.title', text: block_title)
      expect(page).to have_selector('.body', text: block_default_layout.body)
    end

  end
end
