Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :order_items, only: [:create, :update, :destroy, :index]

  resources :products, only: [:index, :show]

  resources :users, only: [:show] do
    collection do
      post '/login', to: 'users#login'
      # post '/signup', to: 'users#signup'
    end
  end

  resources :questions, only: [:create]

  resources :orders, only: [:create, :index, :show]
end


# URI Pattern                Controller#Action
# GET    /order_items(.:format)     order_items#index
# POST   /order_items(.:format)     order_items#create
# PATCH  /order_items/:id(.:format) order_items#update
# PUT    /order_items/:id(.:format) order_items#update
# DELETE /order_items/:id(.:format) order_items#destroy
# GET    /products(.:format)        products#index
# GET    /products/:id(.:format)    products#show
# POST   /users/login(.:format)     users#login
# GET    /users/:id(.:format)       users#show
# POST   /questions(.:format)       questions#create
# GET    /orders(.:format)          orders#index
# POST   /orders(.:format)          orders#create
# GET    /orders/:id(.:format)      orders#show
