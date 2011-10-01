SSEDAP::Application.routes.draw do

  match '/authorize', to: 'sessions#authorize'
  # match '/auth/:provider/callback', :to => 'sessions#callback'
  # match '/auth/failure', :to => 'sessions#login_failure'

  root :to => 'root#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
