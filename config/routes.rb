Rails.application.routes.draw do
  resources :products
  scope module: 'api' do
    namespace :v1 do
      resources :categories
      resources :products
    end
  end
end
