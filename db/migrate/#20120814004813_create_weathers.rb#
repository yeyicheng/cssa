class CreateWeathers < ActiveRecord::Migration
	def change
		create_table :weathers do |t|
			t.string :condition
			t.decimal :temp_c, :precision => 4, :scale => 1
			t.decimal :temp_f, :precision => 4, :scale => 1
			t.string :icon_url
			t.string :location
			
			t.timestamps
		end
	end
end
