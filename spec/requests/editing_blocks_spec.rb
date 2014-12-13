require 'spec_helper'

describe NoCms::Admin::Pages do

  context "when editing a page", js: true do

    let(:nocms_page) { create :nocms_page }
    let(:block_default_layout) { create :block, layout: 'default', page: nocms_page, title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph }
    let(:block_title) { Faker::Lorem.sentence }
    let(:block_column) { Faker::Lorem.sentence }

    subject { page }

    before do

      block_default_layout

      visit no_cms_admin_pages.edit_page_path(nocms_page)

      within("#content_block_#{block_default_layout.id}") do

        select I18n.t('no_cms.pages.blocks.layouts.title-3_columns'), from: "page_blocks_attributes_0_layout"

        fill_in I18n.t('activerecord.attributes.no_cms/pages/block.title'), with: block_title
        fill_in I18n.t('activerecord.attributes.no_cms/pages/block.column_1'), with: block_column

      end

      click_button(I18n.t('no_cms.admin.pages.pages.toolbar_right.submit'))

    end

    it "should show the edited contents" do
      visit nocms_page.path
      expect(page).to have_selector('.title', text: block_title)
      expect(page).to have_selector('.column_1', text: block_column)
    end

  end
end
