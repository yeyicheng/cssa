
class MicropostsController < ApplicationController
	before_filter :authenticate, :only => [:create, :destroy]
	before_filter :authorized_user, :only => [:destroy]
	
	def create
		@micropost = current_user.microposts.build(params[:micropost])
		if @micropost.save
			flash[:success] = "Micropost created!"
			redirect_back_or current_user
		else
			flash[:error] = "Fail to create micropost!"
			@feed_items = []
			redirect_back_or current_user
		end
	end
	
	def destroy
		@micropost.destroy
		redirect_back_or @micropost.user
	end
	
	private
		def authorized_user
			@micropost = Micropost.find(params[:id])
			redirect_back_or @micropost.user unless current_user?(@micropost.user)
		end
end
