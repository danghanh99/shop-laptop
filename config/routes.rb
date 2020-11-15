Rails.application.routes.draw do
  scope module: 'api' do
    namespace :v1 do
      # Session start
      post  'login', to: 'sessions#create'
      # Session end
      resources :password, only: %i[create]
      patch 'password/reset', to: 'password#update'
      post 'password/validate_token', to: 'password#validate_token'
      resources :users do
        member do
          patch '/password', to: 'users#update_password'
          get 'history_orders', to: 'customers/orders#index'
          get 'cart', to: 'customers/carts#index'
        end
      end

      resources :categories
      resources :products
      resources :carts
      resources :orders do
        member do
          patch 'cancel', to: 'orders#cancel'
          patch 'approve', to: 'orders#approve'
          patch 'done', to: 'orders#done'
          patch 'deny', to: 'orders#deny'
        end
      end
      resources :order_items do
        member do
          put '/quantity', to: 'order_items#update_quantity'
        end
      end
    end
  end
end
