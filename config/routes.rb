SSEDAP::Application.routes.draw do

  scope :constraints => { protocol: Rails.env.production? ? 'https'  : 'http' } do
    match 'api/:action', controller: 'api'
    match 'api/*method', controller: 'api'
  end

  # intentionally fail on all api methods if we're in production and not using SSL
  if Rails.env.production?
    scope :constraints => { protocol: 'http' } do
      match 'api/*api_method', :to => 'api#no_ssl_error'
    end
  end

  root :to => 'root#index'
end

