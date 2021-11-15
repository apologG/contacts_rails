Rails.application.routes.draw do
 
  devise_for :users
  resources :contacts, exept: %i(show) do
    get 'autocomplete', on: :collection
  end

  post '/groups', to: 'groups#create'
  root 'contacts#index'
end
