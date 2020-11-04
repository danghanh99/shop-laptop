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
      resources :order_items
      resources :users do
        member do
          patch '/password', to: 'users#update_password'
        end
      end
    end
  end
end
