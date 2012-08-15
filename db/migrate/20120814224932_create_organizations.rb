class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.text :description
      t.string :email
      t.string :logo_url

      t.timestamps
    end
    
    add_index :organizations, :name, unique: true
  end
end
