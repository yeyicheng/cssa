class AddIndexToOrgRelationships < ActiveRecord::Migration
	def change
		add_index :org_relationships, :club_id
		add_index :org_relationships, :member_id
		add_index :org_relationships, [:member_id, :club_id], :unique => true
	end
end
