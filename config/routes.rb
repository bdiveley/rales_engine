Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get '/api/v1/merchants/find', to: 'api/v1/merchants/search#show'

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random.json', to: 'search#show'
      end
      resources :merchants, only: [:index, :show]
    end
  end

end
