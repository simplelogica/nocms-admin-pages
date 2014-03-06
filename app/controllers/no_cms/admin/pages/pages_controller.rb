require_dependency "no_cms/admin/pages/application_controller"

module NoCms::Admin::Pages
  class PagesController < ApplicationController
    def index
      @roots = NoCms::Pages::Page.roots
    end

    def new
    end

    def edit
    end
  end
end
