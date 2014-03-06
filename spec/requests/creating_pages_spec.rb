require 'spec_helper'

describe NoCms::Admin::Pages do

  context "when creating a new page" do

    let(:page_title) { Faker::Lorem.sentence }
    let(:page_path) { "/#{page_title.parameterize}" }
    let(:page_body) { Faker::Lorem.paragraph }

    subject { page }

    before do
      visit no_cms_admin_pages.new_page_path

      fill_in I18n.t('activerecord.attributes.no_cms/pages/page.title'), with: page_title
      fill_in I18n.t('activerecord.attributes.no_cms/pages/page.body'), with: page_body

      click_button(I18n.t('no_cms.admin.pages.pages.new.submit'))
    end

    it "should show the page in the admin index" do
      expect(current_path).to eq no_cms_admin_pages.pages_path
      expect(subject).to have_selector 'li', text: page_title
    end

    it "should create a new accessible page" do
      expect(subject.status_code).to eq 200
      expect(subject).to have_text page_title
    end

  end
end
