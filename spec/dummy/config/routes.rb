Rails.application.routes.draw do

  mount NoCms::Admin::Pages::Engine => "/admin/pages"
end
