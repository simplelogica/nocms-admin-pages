require 'spec_helper'

describe NoCms::Admin::Pages do

  context "when creating a new page", js: true do

    let(:page_title) { Faker::Lorem.sentence }
    let(:page_path) { "/#{page_title.parameterize}" }
    let(:page_body) { Faker::Lorem.paragraph }

    subject { page }

    before do
      visit no_cms_admin_pages.new_page_path

      fill_in I18n.t('activerecord.attributes.no_cms/pages/page.title'), with: page_title
      fill_in I18n.t('activerecord.attributes.no_cms/pages/page.body'), with: page_body

      click_button(I18n.t('no_cms.admin.pages.pages.toolbar_right.submit_and_hide'))
    end

    it "should show the page in the admin index" do
      expect(current_path).to eq no_cms_admin_pages.pages_path
      expect(subject).to have_selector 'li', text: page_title
    end

    it "should create a new accessible page" do
      visit page_path
      expect(subject.status_code).to eq 200
      expect(subject).to have_text page_title
    end

  end

  context "when using different buttons to submit" do
    let(:page_title) { Faker::Lorem.sentence }
    let(:page_path) { "/#{page_title.parameterize}" }
    let(:page_body) { Faker::Lorem.paragraph }

    subject { page }

    before do
      visit no_cms_admin_pages.new_page_path

      fill_in I18n.t('activerecord.attributes.no_cms/pages/page.title'), with: page_title
      fill_in I18n.t('activerecord.attributes.no_cms/pages/page.body'), with: page_body

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
