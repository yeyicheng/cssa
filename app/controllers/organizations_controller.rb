class OrganizationsController < ApplicationController
	before_filter :authenticate, :only => [:show]
	before_filter :admin_auth, :except => [:index, :show, :members]

	def new
		@user = current_user

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
		@user = current_user
		@micropost = Micropost.new
		@feed_items = current_user.feed.paginate(:page => params[:feed_page], :per_page => 8)

		@category = {'Default' => 0, 'Academic' => 1, 'Sports' => 2}
		@club = Organizations.find(params[:id])
		@title = 'Clubs | ' + @club[:name] +' | Edit'
	end
	
	def update
		@club = Organizations.find(params[:id])
		if @club.update_attributes(params[:club])
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

		@club = Organizations.find(params[:id])
		@members = @club.members.paginate(:page => params[:member_page], :per_page => 15)
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
