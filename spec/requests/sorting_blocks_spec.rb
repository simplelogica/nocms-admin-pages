require 'spec_helper'

describe NoCms::Admin::Pages do

  context "when sorting blocks", js: true do

    let(:nocms_page) { create :nocms_page }
    let(:first_block) { create :block, layout: 'default', page: nocms_page, title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph }
    let(:second_block) { create :block, layout: 'default', page: nocms_page, title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph }


    before do

      first_block
      second_block

      visit no_cms_admin_pages.edit_page_path(nocms_page)

    end
    context "when moving down blocks", js: true do
      before do
        within("#content_block_#{first_block.id}") do
          click_link I18n.t('no_cms.admin.pages.blocks.form.move_down')
        end

        click_button(I18n.t('no_cms.admin.pages.pages.toolbar_right.submit'))
      end

      it "should sort the blocks" do

        visit nocms_page.path

        expect(page).to have_selector('.block:first-of-type .title', text: second_block.title)
        expect(page).to have_selector('.block:last-of-type .title', text: first_block.title)

      end
    end

    context "when moving up blocks", js: true do
      before do
        within("#content_block_#{second_block.id}") do
          click_link I18n.t('no_cms.admin.pages.blocks.form.move_up')
        end

        click_button(I18n.t('no_cms.admin.pages.pages.toolbar_right.submit'))
      end

      it "should sort the blocks" do

        visit nocms_page.path

        expect(page).to have_selector('.block:first-of-type .title', text: second_block.title)
        expect(page).to have_selector('.block:last-of-type .title', text: first_block.title)

      end
    end
  end

  context "when sorting nested blocks", js: true do

    let(:nocms_page) { create :nocms_page }
    let(:block_container) { create :block, layout: 'container_with_background', page: nocms_page }
    let(:first_block_nested) { create :block, layout: 'logo-caption', page: nocms_page, caption: Faker::Lorem.sentence, parent: block_container }
    let(:second_block_nested) { create :block, layout: 'logo-caption', page: nocms_page, caption: Faker::Lorem.sentence, parent: block_container }

    before do

      first_block_nested
      second_block_nested

      visit no_cms_admin_pages.edit_page_path(nocms_page)

    end
    context "when moving down nested blocks", js: true do
      before do
        within("#content_block_#{first_block_nested.id}") do
          click_link I18n.t('no_cms.admin.pages.blocks.form.move_down')
        end

        click_button(I18n.t('no_cms.admin.pages.pages.toolbar_right.submit'))
      end

      it "should sort the blocks" do

        visit nocms_page.path

        expect(page).to have_selector('.logo_block:first-of-type .caption', text: second_block_nested.caption)
        expect(page).to have_selector('.logo_block:last-of-type .caption', text: first_block_nested.caption)

      end
    end

    context "when moving up blocks", js: true do
      before do
        within("#content_block_#{second_block_nested.id}") do
          click_link I18n.t('no_cms.admin.pages.blocks.form.move_up')
        end

        click_button(I18n.t('no_cms.admin.pages.pages.toolbar_right.submit'))
      end

      it "should sort the blocks" do

        visit nocms_page.path

        expect(page).to have_selector('.logo_block:first-of-type .caption', text: second_block_nested.caption)
        expect(page).to have_selector('.logo_block:last-of-type .caption', text: first_block_nested.caption)

      end
    end
  end

end
