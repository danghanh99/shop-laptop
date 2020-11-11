Rails.application.routes.draw do
  scope module: 'api' do
    namespace :v1 do
      # Session start
      post  'login', to: 'sessions#create'
      # Session end
      resources :categories
      resources :products
      resources :carts
      resources :orders
      resources :order_items do
        member do
          put '/quantity', to: 'order_items#update_quantity'
        end
      end
      post 'password/validate_token', to: 'password#validate_token'
      resources :password, only: %i[create]
      patch 'password/reset', to: 'password#update'
      resources :users do
        member do
          patch '/password', to: 'users#update_password'
          get 'history_orders', to: ''
        end
      end
    end
  end
end
