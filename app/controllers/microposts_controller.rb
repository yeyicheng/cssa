
class MicropostsController < ApplicationController
	before_filter :authenticate, :only => [:create, :destroy]
	
	def create
		@micropost = current_user.microposts.build(params[:micropost])
		if @micropost.save
			flash[:success] = "Micropost created!"
			redirect_to current_user
		else
			render current_user
		end
	end
	
	def destroy
		@ms = Micropost.find(params[:id])
		@ms.destroy
	end
end
