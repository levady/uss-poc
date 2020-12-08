Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'visitors/create'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      scope format: true, constraints: { format: :json } do
        resources :visitors, only: %i[ create ]
        resources :rides, only: %i[ index ]
      end
    end
  end
end
