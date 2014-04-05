require 'spec_helper'

describe NoCms::Admin::Pages do

  context "when removing blocks", js: true do

    let(:nocms_page) { create :nocms_page }
    let(:block_default_layout) { create :nocms_block, layout: 'default', page: nocms_page, title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph }

    subject { page }

    before do

      block_default_layout

      visit no_cms_admin_pages.edit_page_path(nocms_page)

      within("#content_block_#{block_default_layout.id}") do
        click_link I18n.t('no_cms.admin.pages.blocks.form.remove')
      end

      click_button(I18n.t('no_cms.admin.pages.pages.toolbar_right.submit'))

    end

    it "should not show the removed contents" do
      visit nocms_page.path
      expect(page).to_not have_selector('.title', text: block_default_layout.title)
      expect(page).to_not have_selector('.body', text:  block_default_layout.body)
    end

  end
end
