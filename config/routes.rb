Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'search#show'
      end
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index]
        resources :invoices, only: [:index]
      end
      namespace :customers do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'search#show'
      end
      resources :customers, only: [:index, :show] do
        resources :invoices, only: [:index]
        resources :transactions, only: [:index]
      end
      namespace :items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'search#show'
      end
      resources :items, only: [:index, :show] do
      #   resources :invoice_items, only: [:index]
      #   # resources :merchants, only: [:show]
      #   get '/merchant', to: 'merchants#show'
      end
      namespace :invoices do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'search#show'
      end
      resources :invoices, only: [:index, :show] do
      #   resources :invoice_items, only: [:index]
      #   resources :merchants, only: [:show]
      #   resources :transactions, only: [:index]
      #   resources :customers, only: [:show]
      #   resources :items, only: [:index]
      end
      namespace :invoice_items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'search#show'
      end
      resources :invoice_items, only: [:index, :show] do
      #   resources :invoices, only: [:show]
      #   resources :items, only: [:show]
      end
      namespace :transactions do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'search#show'
      end
      resources :transactions, only: [:index, :show] do
      #   resources :invoices, only: [:show]
      end
    end
  end
end
