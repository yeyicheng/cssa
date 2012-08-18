Cssa::Application.routes.draw do
	# devise_for :users

	resources :services, :only => [:index, :create, :destroy]
	resources :organizations
	resources :org_relationships, :only => [:create, :destroy]
	resources :member_relationships, :only => [:create, :destroy]
	resources :weathers, :only => [:index]
	resources :users
	resources :sessions, :only => [:new, :create, :destroy]
	resources :microposts, :only => [:create, :destroy]
	resources :relationships, :only => [:create, :destroy]
	resources :users do
		member do
			get :following, :followers, :services, :clubs
		end
	end
	resources :organizations do
		member do
			get :members
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
	get "users/new"
	get "pages/contact"
	get "pages/about"
	get "pages/home"
	get "pages/art"
	get "pages/links"
	get "pages/service"
	
	root :to => 'pages#home'
	match '/contact', :to => 'pages#contact'
	match '/about', :to => "pages#about"
	match '/club', :to => "organizations#index"
	match '/links', :to => 'pages#link'
	match '/home', :to => "pages#home"
	match '/links', to: "pages#link"
	match '/welcome', :to => "pages#welcome"
	match '/handbook', :to => "pages#handbook"
	match '/art', :to => "pages#art"
	match '/news', :to => "pages#news"
	match '/cssa_services' => "pages#service"
	match '/sign_up', :to => "users#new"
	match '/sign_in', :to => "sessions#new"
	match '/sign_out', :to => "sessions#destroy"
	match '/users', :to => "users#index"
	match '/organizations', :to=> 'organizations#index'
	match '/auth/:provider/callback', :to => 'services#create' 
	match '/auth/failure', :to => 'services#failure'
	
	# match 'http://hollow-waterfall-1839.herokuapp.com/auth/:provider/callback', :to => 'services#create' 
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
