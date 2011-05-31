class CreateSponsors < ActiveRecord::Migration
  def self.up
    create_table :sponsors do |t|
      t.string :name
      t.text :description
      t.string :logo
      t.string :website
    end
  end

  def self.down
    drop_table :sponsors
  end
end
