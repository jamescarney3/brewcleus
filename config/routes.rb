Rails.application.routes.draw do
  root to: "static_pages#root"

  namespace :api, defaults: { format: :json } do
    # get "recipes/random/:num", to: "recipes#random" <--- THIS IS HOW TO DO THIS EXPLICITLY
    resources :users, only: [:show, :create, :update, :destroy]
    get "recipes/:id/author_id", to: "recipes#verify_author"
    resources :recipes, only: [:show, :create, :update, :destroy]
    resources :ingredients, only: [:index]
    resources :recipe_ingredients, only: [:show, :destroy]
    resources :batches, only: [:show]
    resource :session, only: [:show, :create, :destroy]
  end

  # get "/auth/:provider/callback", to: "api/sessions#omniauth"
end
