require 'spec_helper'

describe NoCms::Admin::Pages do

  context "when hiding a block", js: true do

    let(:nocms_page) { create :nocms_page }
    let(:block) { create :nocms_block, layout: 'default', page: nocms_page, title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph }


    before do

      block

      visit no_cms_admin_pages.edit_page_path(nocms_page)

      within("#content_block_#{block.id}") do
        click_link I18n.t('no_cms.admin.pages.blocks.form.hide')
      end

      click_button(I18n.t('no_cms.admin.pages.pages.toolbar_right.submit'))
    end

    it "should hide the block" do

      visit nocms_page.path

      expect(page).to_not have_selector('.block .title', text: block.title)

    end

  end

  context "when hiding nested blocks", js: true do

    let(:nocms_page) { create :nocms_page }
    let(:block_container) { create :nocms_block, layout: 'container_with_background', page: nocms_page }
    let(:block_nested) { create :nocms_block, layout: 'logo-caption', page: nocms_page, caption: Faker::Lorem.sentence, parent: block_container }

    before do

      block_nested

      visit no_cms_admin_pages.edit_page_path(nocms_page)

      within("#content_block_#{block_nested.id}") do
        click_link I18n.t('no_cms.admin.pages.blocks.form.move_down')
      end

      click_button(I18n.t('no_cms.admin.pages.pages.toolbar_right.submit'))
    end

    it "should hide the blocks" do

      visit nocms_page.path

      expect(page).to have_selector('.logo_block .caption', text: block_nested.caption)

    end

  end

end
