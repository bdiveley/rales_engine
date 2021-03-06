Rails.application.routes.draw do

  get "/", to: "welcome#index", as: "welcome"

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'search#show'
        get '/most_revenue', to: "all_merch_revenue#index"
        get '/most_items', to: "all_merch_items#index"
        get '/revenue', to: "all_merch_revenue#show"
        get '/:id/revenue', to: "one_merch_revenue#show"
        get '/:id/favorite_customer', to: "favorites#show"
      end

      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index]
        resources :invoices, only: [:index]
      end

      namespace :customers do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'search#show'
        get '/:id/favorite_merchant', to: "favorites#show"
      end

      resources :customers, only: [:index, :show] do
        resources :invoices, only: [:index]
        resources :transactions, only: [:index]
      end

      namespace :items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'search#show'
        get '/most_revenue', to: 'revenue#index'
        get '/most_items', to: 'best#index'
        get '/:id/best_day', to: 'best#show'
      end

      resources :items, only: [:index, :show] do
        resources :invoice_items, only: [:index]
        get '/merchant', to: 'merchants#show'
      end

      namespace :invoice_items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'search#show'
      end

      resources :invoice_items, only: [:index, :show] do
        get '/invoice', to: "invoices#show"
        get '/item', to: "items#show"
      end

      namespace :invoices do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'search#show'
      end

      resources :invoices, only: [:index, :show] do
        get '/merchant', to: "merchants#show"
        get '/customer', to: "customers#show"
        resources :invoice_items, only: [:index]
        resources :transactions, only: [:index]
        resources :items, only: [:index]
      end

      namespace :transactions do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'search#show'
      end

      resources :transactions, only: [:index, :show] do
        get '/invoice', to: "invoices#show"
      end
    end
  end
end
