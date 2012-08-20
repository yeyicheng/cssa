class MemberRelationshipsController < ApplicationController
	before_filter :admin_auth
	respond_to :html, :js
	
	def create
		@member = User.find(params[:member_relationship][:member_id])
		@club = MemberRelationship.find(params[:id]).club
		@club.accept!(@member)
		respond_with @member
	end
	
	def destroy
		@member = MemberRelationship.find(params[:id]).member
		@club = MemberRelationship.find(params[:id]).club
		@club.remove!(@member)
		respond_with @member
	end
end
