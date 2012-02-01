SSEDAP::Application.routes.draw do

  match '/auth', to: 'auth#index'
  match '/auth/logout', to: 'auth#logout'
  post '/auth(/:action)', controller: 'auth'

  match '/dashboard', to: 'dashboard#index'
  resources :directory_users

  protocol = ({ protocol: 'https' } if Rails.env.production?) || {}
  scope :constraints => protocol do
    match '/api/:action', controller: 'api', via: [:post]
    match '/api/*method', to: 'api#undefined_method', via: [:get, :post]
  end

  # intentionally fail on all api methods if we're in production and not using SSL
  if Rails.env.production?
    scope :constraints => { protocol: 'http' } do
      match '/api/*method', to: 'api#no_ssl_error', via: [:get, :post]
    end
  end

  root :to => 'root#index'
end

