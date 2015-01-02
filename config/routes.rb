NoCms::Admin::Pages::Engine.routes.draw do
  
  root to: "pages#index"

  resources :pages do |pages|
    member do
      patch :preview
    end
  end
end
