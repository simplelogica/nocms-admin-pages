require_dependency "no_cms/admin/pages/application_controller"

module NoCms::Admin::Pages
  class PagesController < ApplicationController

    before_filter :load_page, only: [:edit, :update, :destroy]
    before_filter :load_roots, only: [:index, :new, :edit]


    def new
      @page = NoCms::Pages::Page.new
    end

    def create
      @page = NoCms::Pages::Page.new page_params
      if @page.save
        redirect_to pages_path
      else
        load_roots
        render :new
      end
    end

    def edit
      NoCms::Pages.block_layouts.each do |name, _|
        @page.blocks.build layout: name
      end
    end

    def update
      if @page.update_attributes page_params
        redirect_to pages_path
      else
        load_roots
        render :new
      end
    end

    def destroy
      @page.destroy
      redirect_to pages_path
    end

    private

    def load_page
      @page = NoCms::Pages::Page.find(params[:id])
    end

    def load_roots
      @roots = NoCms::Pages::Page.roots
    end

    def page_params
      page_params = params.require(:page).permit(:title, :body, :parent_id)
      page_params.merge!(blocks_attributes: params[:page][:blocks_attributes]) unless params[:page][:blocks_attributes].blank?
      page_params
    end

  end
end
