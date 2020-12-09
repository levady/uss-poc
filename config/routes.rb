Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      scope format: true, constraints: { format: :json } do
        resources :visitors, only: %i[ create ]
        resources :rides, only: %i[ index ]
      end
    end
  end

  # TODO: protect with authentication
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
