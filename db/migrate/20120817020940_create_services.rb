class CreateServices < ActiveRecord::Migration
	def change
		drop_table :services
		create_table :services do |t|
			t.integer :user_id
			t.string :provider
			t.string :uid
			
			t.timestamps
		end
	end
end
