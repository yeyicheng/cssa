class OrganizationsController < ApplicationController
	before_filter :authenticate, :only => [:index, :show]
	before_filter :admin_auth, :except => [:index, :show, :members]

	def index
		@title = 'Clubs'
		@organizations = Organizations.paginate(:page => params[:page], :per_page => 10)
	end
	
	def new
		@title = 'Clubs | New'
		@club = Organizations.new
	end
	
	def create
		@club = Organization.new(params[:club])
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
		@club = Organizations.find(params[:id])
		@title = 'Clubs | ' + @club[:name] +' | Edit'
	end
	
	def update
	end
	
	def show
		@club = Organizations.find(params[:id])
		@title = 'Clubs | ' + @club[:name]
	end
	
	def destroy
		Organizations.find(params[:id]).destroy
		redirect_to organizations_path
	end
  
	def members        
		@club = Organization.find(params[:id])
		@title = 'Clubs | ' + @club[:name] + ' | Members'
		@members = @club.members.paginate(:page => params[:members_page], :per_page => 20)
		# render 'show_member'
	end
	
	def waitlists 
		@club = Organization.find(params[:id])
		@title = 'Clubs | ' + @club[:name] + ' | Applicants'
		@waitlists = @club.show_waitlist.paginate(:page => params[:applicants_page], :per_page => 20)
		# render 'show_member'
	end
end
