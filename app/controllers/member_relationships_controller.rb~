class MemberRelationshipsController < ApplicationController
	before_filter :admin_auth
	respond_to :html, :js
	
	def create
		@member = User.find(params[:member_relationship][:member_id])
		@club = Organization.find(session[:current_club])
		@club.accept! @member
		respond_with @club
	end
	
	def destroy
		@member = MemberRelationship.find(params[:id]).member
		@club = MemberRelationship.find(params[:id]).club
		@club.remove!(@member)
		respond_with @club
	end
end
