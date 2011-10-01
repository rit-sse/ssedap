SSEDAP::Application.routes.draw do

  match '/authorize', to: 'sessions#authorize'

  root :to => 'root#index'
end

