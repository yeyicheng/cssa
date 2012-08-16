Cssa::Application.routes.draw do
  get "oauth/index"

	resources :organizations
	resources :weathers, :only => [:index]
	resources :users
	resources :sessions, :only => [:new, :create, :destroy]
	resources :microposts, :only => [:create, :destroy]
	resources :relationships, :only => [:create, :destroy]
	resources :users do
		member do
			get :following, :followers
		end
	end
	       
	get "organizations/index"

	get "organizations/new"
	
	get "organizations/edit"
	
	get "organizations/show"
	
	get "weathers/index"
	
	get "sessions/new"

	get "users/index"

	get "pages/sign_in"

	get "users/show"

	get "users/new"

	get "pages/contact"

	get "pages/about"

	get "pages/home"
	
	get "pages/news"

	get "pages/art"
	
	get "pages/links"

	root :to => 'pages#home'
	
	match '/contact', :to => 'pages#contact'

	match '/about', :to => "pages#about"

	match '/club', :to => "organizations#index"

	match '/home', :to => "pages#home"
                                        
	match '/welcome', :to => "pages#welcome"
	
	match '/service', :to => "pages#service"
	
	match '/handbook', :to => "pages#handbook"
	
	match '/art', :to => "pages#art"
	
	match '/links', :to => "pages#links"
	
	match '/news', :to => "pages#news"
	
	match '/sign_up', :to => "users#new"

	match '/sign_in', :to => "sessions#new"
	
	match '/sign_out', :to => "sessions#destroy"
	
	match '/users', :to => "users#index"

	match '/organizations', to: 'organizations#index'
	
	match '/oauth2/callback', to: 'oauth#index'
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
