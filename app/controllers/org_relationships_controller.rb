class OrgRelationshipsController < ApplicationController
	before_filter :authenticate
	respond_to :html, :js
	
	def create
		@club = Organization.find(params[:org_relationship][:club_id])
		current_user.join!(@club)
		respond_with @club
	end
	
	def destroy
		@club = OrgRelationships.find(params[:id]).club
		current_user.quit!(@club)
		respond_with @club
	end
end
