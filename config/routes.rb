VideoSite::Application.routes.draw do
  get "log_in" => "sessions#new", :as => "log_in"
	get "sign_up" => "users#new", :as => "sign_up"
	get "log_out" => "sessions#destroy", :as => "log_out"
  root :to => 'video#index'
	resources :users
	resources :sessions
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
   match ':controller(/:action(/:id(.:format)))'
end
