Rails.application.routes.draw do
 
  resources :contacts, exept: %i(show) do
    get 'autocomplete', on: :collection
  end
  # resources :groups, only: %i(create)
  post '/groups', to: 'groups#create'
  root 'contacts#index'
end
