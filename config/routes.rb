Rails.application.routes.draw do
  scope module: 'api' do
    namespace :v1 do
      resources :categories
      resources :products
      resources :users do
        member do
          patch '/password', to: 'users#update_password'
        end
      end
    end
  end
end
