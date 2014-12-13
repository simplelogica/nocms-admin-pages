require 'spec_helper'

describe NoCms::Admin::Pages do

  context "when removing blocks", js: true do

    let(:nocms_page) { create :nocms_page }
    let(:block_default_layout) { create :block, layout: 'default', title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph }

    subject { page }

    before do

      nocms_page.blocks << block_default_layout

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

  context "when removing nested blocks", js: true do

    let(:nocms_page) { create :nocms_page }
    let(:block_container) { create :block, layout: 'container_with_background' }
    let(:block_nested) { create :block, layout: 'logo-caption', caption: Faker::Lorem.sentence, parent: block_container }

    subject { page }

    before do

      nocms_page.blocks <<  block_container
      nocms_page.blocks << block_nested

      visit no_cms_admin_pages.edit_page_path(nocms_page)

      within("#content_block_#{block_nested.id}") do
        click_link I18n.t('no_cms.admin.pages.blocks.form.remove')
      end

      click_button(I18n.t('no_cms.admin.pages.pages.toolbar_right.submit'))

    end

    it "should not show the removed contents" do
      visit nocms_page.path
      expect(page).to_not have_selector('.caption', text: block_nested.caption)
    end

  end

  context "when removing parent of nested blocks", js: true do

    let(:nocms_page) { create :nocms_page }
    let(:block_container) { create :block, layout: 'container_with_background' }
    let(:block_nested) { create :block, layout: 'logo-caption', caption: Faker::Lorem.sentence, parent: block_container }

    subject { page }

    before do

      nocms_page.blocks << block_container
      nocms_page.blocks << block_nested

      visit no_cms_admin_pages.edit_page_path(nocms_page)

      within("#content_block_#{block_container.id}>.b-title>.mo") do
        click_link I18n.t('no_cms.admin.pages.blocks.form.remove')
      end

      click_button(I18n.t('no_cms.admin.pages.pages.toolbar_right.submit'))

    end

    it "should not show the removed child contents" do
      visit nocms_page.path
      expect(page).to_not have_selector('.caption', text: block_nested.caption)
    end

  end
end
