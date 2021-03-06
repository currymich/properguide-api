Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :products, only: [:index, :show]

  resources :users, only: [:update] do
    collection do
      post '/login', to: 'users#login'
    end
  end

  resources :braintree, only: [] do
    collection do
      post '/client_token', to: 'braintree#client_token'
      post '/checkout', to: 'braintree#checkout'
    end
  end

  resources :payments, only: [:create]

  resources :dentists, only: [:show, :create, :index, :update]

  resources :questions, only: [:create]

  resources :orders, only: [:create, :index, :destroy, :show, :update] do
    collection do
      get '/statuses', to: 'orders#statuses'
    end
    resources :order_items, only: [:create, :update, :destroy, :index]
  end
end
