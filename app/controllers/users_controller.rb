
class UsersController < ApplicationController
	before_filter :authenticate, :except => [:new, :create]
	before_filter :correct_user, :only => [:edit, :update]
	before_filter :admin_auth, :only => [:destroy]
	
	def new
		if signed_in?
			redirect_to root_path
			flash[:error] = "Please sign out to sign up for another account."
		else
			@user = User.new
			@title = "Sign up"
		end
	end
	
	def create
		if signed_in?
			redirect_to root_path
			flash[:error] = "Please sign out to sign up for another account."
			return
		end
		@user = User.new(params[:user])
		if @user.save
			sign_in @user
			flash[:success] = "Welcome to the Sample App!"
			redirect_to @user
		else
			@title = "Sign up"
			render 'new'
			flash[:error] = "Please try again."
		end
	end
	
	def edit
		@user = User.find(params[:id])
		@title = "Edit user"
	end
	
	def update
		@user = User.find(params[:id])
		if @user.update_attributes(params[:user])
			flash[:success] = "Profile updated."
			redirect_to @user
		else
			@title = "Edit user"
			render 'edit'
		end
	end
	
	def show
		@user = User.find(params[:id])
		@microposts = @user.microposts.paginate(:page => params[:page], :per_page => 10)
		@title = @user[:name]
		if !signed_in?
			redirect_to sign_in_path
		elsif correct_user?
			store_location
			@micropost = Micropost.new
			@feed_items = current_user.feed.paginate(:page => params[:page], :per_page => 15)
		else
			store_location
			@micropost = Micropost.new
			@feed_items = @microposts
			@microposts = current_user.microposts.paginate(:page => params[:page], :per_page => 8)
		end
	end
	
	def index
		@title = "All users"
		@users = User.paginate(:page => params[:page], :per_page => 20)
		@feed_items = current_user.feed.paginate(:page => params[:page], :per_page => 20)
	end

	def destroy
		@user = User.find(params[:id])
		if @user.admin?
			flash[:error] = "Cannot delete administrators."
		else
			@user.destroy
			flash[:success] = "User #{@user[:name]} deleted."
		end
		redirect_to users_path
	end
	
	def following
		@title = "Following"
		@user = User.find(params[:id])
		@users = @user.following.paginate(:page => params[:page], :per_page => 20)
		render 'show_follow'
	end
	
	def followers
		@title = "Followers"
		@user = User.find(params[:id])
		@users = @user.followers.paginate(:page => params[:page], :per_page => 20)
		render 'show_follow'
	end
	
	private	
		def correct_user
			if params[:id]
				@user = User.find(params[:id])
				redirect_to(root_path) unless current_user?(@user)
			else
				redirect_to(root_path) unless current_user.admin?
			end
		end
end

