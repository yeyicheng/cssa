
class UsersController < ApplicationController
	before_filter :authenticate, :only => [:edit, :update, :show, :index]
	before_filter :correct_user, :only => [:edit, :update, :show, :index]
	
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
			# Handle a successful save.
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
		@title = @user[:name]
	end
	
	def index
		@title = "All users"
		@users = User.paginate(:page => params[:page])
	end

	def destroy
		if !current_user
			redirect_to sign_in_path
		elsif current_user.admin?
			@user = User.find(params[:id])
			if @user.admin?
				flash[:error] = "Cannot delete administrators."
			else
				@user.destroy
				flash[:success] = "User #{@user[:name]} deleted."
			end
			redirect_to users_path
		else
			redirect_to root_path
		end
	end
	
	private
		def authenticate
			deny_access unless signed_in?
		end
		
		def correct_user
			if params[:id]
				@user = User.find(params[:id])
				redirect_to(root_path) unless current_user?(@user)
			else
				redirect_to(root_path) unless current_user.admin?
			end
		end
end

