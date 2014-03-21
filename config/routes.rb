NoCms::Admin::Pages::Engine.routes.draw do
  resources :pages do |pages|
    member do
      patch :preview
    end
  end
end
