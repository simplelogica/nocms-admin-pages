Rails.application.routes.draw do

  mount NoCms::Pages::Engine => "/"
  mount NoCms::Admin::Pages::Engine => "/admin/pages"
end
