class OrganizationsController < ApplicationController
	before_filter :authenticate, :only => [:show, :members]
	before_filter :club_admin_auth, :only => [:edit, :update, :waitlists, :admins]
	before_filter :admin_auth, :only => [:new, :create, :destroy]

	def new
		@user = current_user
		@title = 'Clubs | New'
		@club = Organization.new
	end
	
	def create
		@user = current_user
		@club = Organization.new(params[:organization])
		if @club.save
			flash[:success] = "Welcome to the Sample App!"
			redirect_to @club
		else
			flash[:error] = "Please try again."
			@title = 'Clubs | New'
			render 'new'
		end
	end
	
	def edit
		@club = Organization.find(params[:id])
		@title = 'Clubs | ' + @club[:name] + ' | Edit'
	end
	
	def update
		@user = current_user
		@club = Organization.find(params[:id])
		if @club.update_attributes(params[:organization])
			flash[:success] = "Profile updated."
			redirect_to @club
		else
			@title = "Clubs | " + @club[:name] + " | Edit"
			render 'edit'
		end
	end
	
	def show
		session[:current_club] = params[:id]
		@club = Organization.find(params[:id])
		@members = @club.members.paginate(:page => params[:user_page], :per_page => 15)
		@title = 'Clubs | ' + @club[:name]
		respond_to do |format|
			format.html # show.html.erb
			format.json { render json: @club.to_json(:include => [:members]) }
		end
	end
	
	def destroy
		@user = current_user
		@club = Organization.find(params[:id])
		@club.destroy
		redirect_to category_path(@club.category_id)
	end
  
	def members      
		session[:current_club] = params[:id]
		@club = Organization.find(params[:id])
		@title = 'Clubs | ' + @club[:name] + ' | Members'
		@members = @club.members.paginate(:page => params[:user_page], :per_page => 15)
	end
	
	def waitlists 
		session[:current_club] = params[:id]
		@club = Organization.find(params[:id])
		@title = 'Clubs | ' + @club[:name] + ' | Waitlist'
		@waitlists = @club.applicants.paginate(:page => params[:user_page], :per_page => 15)
	end
	
	def admins
		session[:current_club] = params[:id]
		@club = Organization.find(params[:id])
		@title = 'Clubs | ' + @club[:name] + ' | Admins'
		@admins = @club.admins.paginate(:page => params[:user_page], :per_page => 15)
	end
end
