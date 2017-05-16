Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :order_items, only: [:create, :update, :destroy, :index]

  resources :carts, only: [:show]

  resources :products, only: [:index, :show]

  resources :users, only: [:show] do
    collection do
      post '/login', to: 'users#login'
      post '/signup', to: 'users#signup'
    end
  end

  resources :questions, only: [:create]
end
