Cssa::Application.routes.draw do
	# devise_for :users
	resources :categories
	resources :services, :only => [:index, :create, :destroy]
	resources :organizations, :except => [:index] 
	resources :org_relationships, :only => [:create, :destroy]
	resources :member_relationships, :only => [:create, :destroy]
	resources :weathers, :only => [:index]
	resources :users
	resources :sessions, :only => [:new, :create, :destroy]
	resources :microposts, :only => [:create, :destroy]
	resources :relationships, :only => [:create, :destroy]
	resources :club_admins, :only => [:create, :destroy]
	resources :users do
		member do
			get :following, :followers, :services, :clubs
		end
	end
	resources :categories do
		member do
			get :clubs
		end
	end
	resources :organizations do
		member do
			get :members, :waitlists, :admins
		end
	end
	# get "organizations/index"
	get "organizations/new"
	get "organizations/edit"
	get "organizations/show"
	get "weathers/index"
	# get "sessions/new"
	# get "users/index"
	# get "pages/sign_in"
	# get "users/new"
	# get "pages/contact"
	# get "pages/about"
	# get "pages/home"
	# get "pages/art"
	# get "pages/links"
	# get "pages/service"
	
	root :to => 'pages#home'
	
	match '/contact' => 'pages#contact'
	match '/about' => "pages#about"
	# match '/clubs' => "categories#index"
	match '/links' => 'pages#links'
	# match '/home' => "pages#home"
	match '/welcome' => "pages#welcome"
	match '/welcome/ch' => "pages#welcome_ch"
	match '/handbook' => "pages#handbook"
	match '/art' => "pages#art"
	match '/news' => "pages#news"
	match '/cssa_services' => "pages#service"
	match '/sign_up' => "users#new"
	match '/sign_in' => "sessions#new"
	match '/sign_out' => "sessions#destroy"
	match '/users' => "users#index"
	match '/auth/:provider/callback' => 'services#create' 
	# match '/auth/google_oath2/callback' => 'services#create' 
	match '/auth/failure' => 'services#failure'
	match '/microposts' => 'pages#home'
	match '/users/:id/profile' => 'users#profile', :as => :profile_user
	
	# match 'http://hollow-waterfall-1839.herokuapp.com/auth/:provider/callback' => 'services#create' 
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
