class CreateClubAdmins < ActiveRecord::Migration
	def change
		create_table :club_admins do |t|
			t.integer :club_id
			t.integer :member_id
			
			t.timestamps
		end
		
		add_index :club_admins, [:club_id, :member_id], unique: true
	end
end
