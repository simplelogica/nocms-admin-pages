require 'spec_helper'

describe NoCms::Admin::Pages do

  context "when creating new blocks", js: true do

    let(:nocms_page) { create :nocms_page }
    let(:page_title) { Faker::Lorem.sentence }
    let(:block_title) { Faker::Lorem.sentence }
    let(:block_body) { Faker::Lorem.sentence }

    subject { page }

    before do

      visit no_cms_admin_pages.edit_page_path(nocms_page)


    end

    it "generates new blocks" do

      expect(page).to_not have_selector '.block'

      click_link I18n.t('no_cms.admin.pages.blocks.index.new_block')

      expect(page).to have_selector '.block'

    end

    it "creates new blocks when submitted" do

      click_link I18n.t('no_cms.admin.pages.blocks.index.new_block')

      within('.block') do
        fill_in I18n.t('activerecord.attributes.no_cms/pages/block.title'), with: block_title
        fill_in I18n.t('activerecord.attributes.no_cms/pages/block.body'), with: block_body
      end

      click_button(I18n.t('no_cms.admin.pages.pages.toolbar_right.submit'))

      visit nocms_page.path
      expect(page).to have_selector('.title', text: block_title)
      expect(page).to have_selector('.body', text: block_body)

    end

  end

  context "when creating new nested blocks", js: true do
    let(:nocms_page) { create :nocms_page }
    let(:block_title) { Faker::Lorem.sentence }
    let(:block_body) { Faker::Lorem.sentence }

    let(:block_container) { create :nocms_block, layout: 'container_with_background', page: nocms_page }

    subject { page }

    before do
      block_container
      visit no_cms_admin_pages.edit_page_path(nocms_page)
    end

    it "should show a 'new child block'" do
      expect(page).to have_selector "#content_block_#{block_container.id} .new_content_block"
    end

    it "should create a 'new child block'" do

      expect(page).to_not have_selector "#content_block_#{block_container.id} .block"

      within "#content_block_#{block_container.id}" do
        click_link I18n.t('no_cms.admin.pages.blocks.nested_index.new_block')
      end

      expect(page).to have_selector "#content_block_#{block_container.id} .block"

      within("#content_block_#{block_container.id} .block") do
        fill_in I18n.t('activerecord.attributes.no_cms/pages/block.caption'), with: block_title
      end

      click_button(I18n.t('no_cms.admin.pages.pages.toolbar_right.submit'))

      visit nocms_page.path
      expect(page).to have_selector('.caption', text: block_title)
    end

  end
end
