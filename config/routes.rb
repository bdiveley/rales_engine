Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/api/v1/merchants/find', to: 'search#show'
  
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show]
    end
  end

end
