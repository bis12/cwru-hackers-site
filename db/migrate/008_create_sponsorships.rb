class CreateSponsorships < ActiveRecord::Migration
  def self.up
    create_table :sponsorships do |t|
      t.string :talk_id
      t.string :sponsor_id
    end
  end

  def self.down
    drop_table :sponsorships
  end
end
