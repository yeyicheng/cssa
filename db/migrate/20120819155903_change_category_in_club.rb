class ChangeCategoryInClub < ActiveRecord::Migration
	def change
		remove_index :organizations, [:category, :name]
		remove_column :organizations, :category
	
		add_column :organizations, :category_id, :integer
	end
end
