class CreateCategories < ActiveRecord::Migration
	def change
		create_table :categories do |t|
			t.string 		:name
			t.text			:description
			t.attachment	:avatar
			
			t.timestamps
		end
		
		add_index :categories, :name, unique: true
	end
end
