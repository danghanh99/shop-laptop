Rails.application.routes.draw do
  scope module: 'api' do
    namespace :v1 do
      resources :categories
      resources :products
      resources :users
      resources :carts
      resources :orders
    end
  end
end
