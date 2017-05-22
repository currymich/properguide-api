Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :products, only: [:index, :show]

  resources :users, only: [:show] do
    collection do
      post '/login', to: 'users#login'
    end
  end

  resources :questions, only: [:create]

  resources :orders, only: [:create, :index, :destroy] do
    resources :order_items, only: [:create, :update, :destroy, :index]
  end
end


# Pattern                                           Controller#Action
# GET    /products(.:format)                         products#index
# GET    /products/:id(.:format)                     products#show
# POST   /users/login(.:format)                      users#login
# GET    /users/:id(.:format)                        users#show
# POST   /questions(.:format)                        questions#create
# GET    /orders/:order_id/order_items(.:format)     order_items#index
# POST   /orders/:order_id/order_items(.:format)     order_items#create
# PATCH  /orders/:order_id/order_items/:id(.:format) order_items#update
# PUT    /orders/:order_id/order_items/:id(.:format) order_items#update
# DELETE /orders/:order_id/order_items/:id(.:format) order_items#destroy
# GET    /orders(.:format)                           orders#index
# POST   /orders(.:format)                           orders#create
