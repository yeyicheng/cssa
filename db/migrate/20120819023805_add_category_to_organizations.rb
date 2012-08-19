class AddCategoryToOrganizations < ActiveRecord::Migration
	def change
		add_column :organizations, :category, :integer, :default => 0
		add_index :organizations, [:category, :name], :order => {:category => :asc, :name => :asc}
	end
end
