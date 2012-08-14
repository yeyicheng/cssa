  
class WeathersController < ApplicationController
	before_filter :authenticate
	
	def index
		@weathers = Weather.paginate(:page => params[:page])

		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @weathers }
		end
	end
end
