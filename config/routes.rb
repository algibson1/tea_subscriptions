Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do 
      resources :customers do
        resources :subscriptions, only: [:index, :create, :update], controller: :customer_subscriptions
      end
    end
  end
end
