require 'spec_helper'

describe NoCms::Admin::Pages do

  context "when editing a page", js: true do

    let(:nocms_page) { create :nocms_page }
    let(:block_default_layout) { create :block, layout: 'default', title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph }
    let(:page_title) { Faker::Lorem.sentence }
    let(:block_title) { Faker::Lorem.sentence }

    subject { page }

    before do

      nocms_page.blocks << block_default_layout

      visit no_cms_admin_pages.edit_page_path(nocms_page)

      within('#content_fields') do
        fill_in I18n.t('activerecord.attributes.no_cms/pages/page.title'), with: page_title
      end

      within("#content_block_#{block_default_layout.id}") do
        fill_in I18n.t('activerecord.attributes.no_cms/pages/page.title'), with: block_title
      end

      click_button(I18n.t('no_cms.admin.pages.pages.toolbar_right.submit_and_hide'))
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


  context "when using different buttons to submit" do
    let(:nocms_page) { create :nocms_page }

    subject { page }

    before do
      visit no_cms_admin_pages.edit_page_path(nocms_page)
    end

    context "when submit and new" do
      before do
        click_button(I18n.t('no_cms.admin.pages.pages.toolbar_right.submit_and_new'))
      end

      it "should show the new form" do
        expect(current_path).to eq no_cms_admin_pages.new_page_path
      end
    end

    context "when submit and hide" do
      before do
        click_button(I18n.t('no_cms.admin.pages.pages.toolbar_right.submit_and_hide'))
      end

      it "should show the new form" do
        expect(current_path).to eq no_cms_admin_pages.pages_path
      end
    end

    context "when submit and edit" do
      before do
        click_button(I18n.t('no_cms.admin.pages.pages.toolbar_right.submit'))
      end

      it "should show the new form" do
        expect(current_path).to eq no_cms_admin_pages.edit_page_path(NoCms::Pages::Page.last)
      end
    end
  end

end
