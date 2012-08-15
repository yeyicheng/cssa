class CreateWeathers < ActiveRecord::Migration
	def change
		create_table :weathers do |t|
			t.string :time
			t.string :condition
			t.decimal :temp_c, :precise=>4, :scale=>1
			t.decimal :temp_f, :precise=>4, :scale=>1
			t.string :icon_url
			t.string :location
			
			t.timestamps
		end
		
		add_index :weathers, :time, unique: true
	end
end
