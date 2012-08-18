class CreateMemberRelationships < ActiveRecord::Migration
	def change
		create_table :member_relationships do |t|
			t.integer :club_id
			t.integer :member_id
		
			t.timestamps
		end
	
		add_index :member_relationships, :club_id
		add_index :member_relationships, :member_id
		add_index :member_relationships, [:club_id, :member_id], :unique => true
	end
end
