class CreateOrgRelationships < ActiveRecord::Migration
  def change
    create_table :org_relationships do |t|
      t.integer :club_id
      t.integer :member_id

      t.timestamps
    end
  end
end
