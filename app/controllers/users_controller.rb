
class UsersController < ApplicationController
	def new
		@user = User.new
		@title = "Sign up"
	end
	
	def create
		@user = User.new(params[:user])
		if @user.save
			sign_in @user
			flash[:success] = "Welcome to the Sample App!"
			redirect_to (@user)
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
	
	def show
		@user = User.find(params[:id])
		@title = @user[:name]
	end
	
	def index
		@title = "Users"
	end
end

