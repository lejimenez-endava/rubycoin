Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :core do
    resource :node, only: %i[show] do
      post :gossip
    end
  end

  # Defines the root path route ("/")
  # root "articles#index"
end
