class RemoveLogoUrlFromOrganization < ActiveRecord::Migration
	def change
		remove_column :organizations, :logo_url
	end
end
