
class UsersController < ApplicationController
	# before_filter :authenticate, :except => [:new, :create]
	before_filter :authenticate_user!, :except => [:new, :create]
	# before_filter :correct_user, :only => [:edit, :update]
	# before_filter :admin_auth, :only => [:destroy]
	
	# 
	# def edit
		# @user = User.find(params[:id])
		# @title = @user[:name] + " | Edit"
	# end
	# 
	# def update
		# @user = User.find(params[:id])
		# if @user.update_attributes(params[:user])
			# flash[:success] = "Profile updated."
			# redirect_to @user
		# else
			# @title = "Edit user"
			# render 'edit'
		# end
	# end
	# 
	def show
		@user = User.find(params[:id])
		@microposts = @user.microposts.paginate(:page => params[:micropost_page], :per_page => 10)
		@title = @user[:name]
		store_location
		@micropost = Micropost.new
		@feed_items = current_user.feed.paginate(:page => params[:feed_page], :per_page => 8)
		if session[:authhash]
			user.services.create!(provider: session[:authhash][:provider], uid: session[:authhash][:uid])
			flash[:success] = 'Your ' + @authhash[:provider].capitalize + ' account has been connected to this site.'
			session[:authhash] = nil
			redirect_to user
		end
	end
	
	def index
		@title = "Users"
		@users = User.paginate(:page => params[:page], :per_page => 20)
		@feed_items = current_user.feed.paginate(:page => params[:page], :per_page => 20)
	end
# 
	# def destroy
		# @user = User.find(params[:id])
		# if @user.admin?
			# flash[:error] = "Cannot delete administrators."
		# else
			# @user.destroy
			# flash[:success] = "User #{@user[:name]} deleted."
		# end
		# redirect_to users_path
	# end
	
	def following
		@user = User.find(params[:id])
		@title = @user[:name] + " | Following"
		@users = @user.following.where("follower_id != followed_id").paginate(:page => params[:user_page], :per_page => 15)
		render 'show_follow'
	end
	
	def followers
		@user = User.find(params[:id])
		@title = @user[:name] + " | Followers"
		@users = @user.followers.where("follower_id != followed_id").paginate(:page => params[:user_page], :per_page => 15)
		render 'show_follow'
	end
	
	def services
		@user = User.find(params[:id])
		@title = @user[:name] + " | Services"
		@services = @user.services
	end
	
	def clubs
		@user = User.find(params[:id])
		@title = @user[:name] + " | Clubs"
		@users = @user.clubs.paginate(:page => params[:club_page], :per_page => 10)
		render 'show_follow'
	end
	
	def profile
		@micropost = Micropost.new
		@feed_items = current_user.feed.paginate(:page => params[:feed_page], :per_page => 8)
		@user = User.find(params[:id])
		@title = @user[:name] + ' | Profile'
	end
end

