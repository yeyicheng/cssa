class MemberRelationshipsController < ApplicationController
	before_filter :admin_auth
	respond_to :html, :js
	
	def create
		@member = User.find(params[:member_relationship][:member_id])
		self.club.accept!(@member)
		respond_with @member
	end
	
	def destroy
		@member = MemberRelationships.find(params[:id]).member
		self.club.remove!(@member)
		respond_with @member
	end
end
