class CreateTaggings < ActiveRecord::Migration
  def self.up
    create_table :taggings do |t|
      t.integer :talk_id
      t.integer :person_id
      t.integer :tag_id
    end
  end

  def self.down
    drop_table :taggings
  end
end
