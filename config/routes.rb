Rails.application.routes.draw do
  root to: "static_pages#root"

  namespace :api, defaults: { format: :json } do
    # get "recipes/random/:num", to: "recipes#random" <--- THIS IS HOW TO DO THIS EXPLICITLY
    resources :users, only: [:show, :create]
    resources :recipes, only: [:show]
    resources :batches, only: [:show]
    resource :session, only: [:show, :create, :destroy]
  end

  # get "/auth/:provider/callback", to: "api/sessions#omniauth"
end
