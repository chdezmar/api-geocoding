Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :locations, only: [:create, :index]
  end
end
