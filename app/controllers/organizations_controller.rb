class OrganizationsController < ApplicationController
	before_filter :authenticate, :only => [:index, :show]
	before_filter :admin_auth, :except => [:index, :show]
	
	def index
		@title = 'All clubs'
		@organizations = Organizations.paginate(:page => params[:page], :per_page => 10)
	end
	
	def new
		@title = 'New club'
		@club = Organizations.new
	end
	
	def create
	end
	
	def edit
		@title = "Edit club details"
		@club = Organizations.find(params[:id])
	end
	
	def update
	end
	
	def show
		@club = Organizations.find(params[:id])
		@title = 'Club | ' << @club[:name]
	end
	
	def destroy
		Organizations.find(params[:id]).destroy
		redirect_to organizations_path
	end
  
	def members        
		@club = Organization.find(params[:id])
		@title = 'Club | ' << @club[:name] << ' | Members'
		@members = @club.members.paginate(:page => params[:page], :per_page => 20)
		render 'show_member'
	end
end
