class OrgRelationshipsController < ApplicationController
	before_filter :authenticate
	respond_to :html, :js
	
	def create
		@club = Organization.find(params[:org_relationship][:club_id])
		current_user.join! @club
		respond_with @club
	end
	
	def destroy
		@club = OrgRelationship.find(params[:id]).club
		@member = OrgRelationship.find(params[:id]).member
		if @member.joined? @club
			@member.quit! @club
			respond_with @club
		elsif @member.applied? @club
			@member.cancel! @club
			respond_with @club
		end
	end
end
