SSEDAP::Application.routes.draw do

  match '/auth', to: 'auth#index'
  match '/auth/logout', to: 'auth#logout'
  post '/auth(/:action)', controller: 'auth'

  match '/dashboard', to: 'dashboard#index'
  resources :directory_users

  match '/api/:action', controller: 'api', via: [:post]
  match '/api/*method', to: 'api#undefined_method', via: [:get, :post]

  root :to => 'root#index'
end

