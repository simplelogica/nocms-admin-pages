Rails.application.routes.draw do

  mount NoCms::Admin::Engine => "/admin"
  mount NoCms::Admin::Pages::Engine => "/admin"
  mount NoCms::Pages::Engine => "/"
end
