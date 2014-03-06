require_dependency "no_cms/admin/pages/application_controller"

module NoCms::Admin::Pages
  class PagesController < ApplicationController

    before_filter :load_page, only: [:edit, :update]

    def index
      @roots = NoCms::Pages::Page.roots
    end

    def new
      @page = NoCms::Pages::Page.new
    end

    def create
      @page = NoCms::Pages::Page.new page_params
      if @page.save
        redirect_to pages_path
      else
        render :new
      end
    end

    def update
      if @page.update_attributes page_params
        redirect_to pages_path
      else
        render :new
      end
    end

    private

    def load_page
      @page = NoCms::Pages::Page.find(params[:id])
    end

    def page_params
      params.require(:page).permit(:title, :body)
    end

  end
end
