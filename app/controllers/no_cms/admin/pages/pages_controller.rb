require_dependency "no_cms/admin/pages/application_controller"

module NoCms::Admin::Pages
  class PagesController < ApplicationController
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

    def edit
    end

    def page_params
      params.require(:page).permit(:title, :body)
    end

  end
end
