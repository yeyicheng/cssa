class OrganizationsController < ApplicationController
	before_filter :authenticate, :only => [:show, :members]
	before_filter :admin_auth, :only => [:new, :create, :update, :edit, :destroy, :waitlists]

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
		@user = current_user
		@micropost = Micropost.new
		@feed_items = current_user.feed.paginate(:page => params[:feed_page], :per_page => 8)

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
			@title = "Edit user"
			render 'edit'
		end
	end
	
	def show
		@user = current_user
		@micropost = Micropost.new
		@feed_items = current_user.feed.paginate(:page => params[:feed_page], :per_page => 8)
		session[:current_club] = params[:id]
		@club = Organization.find(params[:id])
		@members = @club.members.paginate(:page => params[:member_page], :per_page => 15)
		@title = 'Clubs | ' + @club[:name]
	end
	
	def destroy
		Organization.find(params[:id]).destroy
		redirect_to organizations_path
	end
  
	def members      
		session[:current_club] = params[:id]
		@club = Organization.find(params[:id])
		@title = 'Clubs | ' + @club[:name] + ' | Members'
		@members = @club.members.paginate(:page => params[:member_page], :per_page => 15)
	end
	
	def waitlists 
		session[:current_club] = params[:id]
		@club = Organization.find(params[:id])
		@title = 'Clubs | ' + @club[:name] + ' | Waitlist'
		@waitlists = @club.applicants.paginate(:page => params[:applicant_page], :per_page => 15)
	end
	
	def admins
		session[:current_club] = params[:id]
		@club = Organization.find(params[:id])
		@title = 'Clubs | ' + @club[:name] + ' | Admins'
		@admins = @club.admins.paginate(:page => params[:admin_page], :per_page => 15)
	end
end
