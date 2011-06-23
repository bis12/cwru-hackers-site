class RemoveFieldsFromTalks < ActiveRecord::Migration
  def self.up
    change_table :talks do |t|
      t.remove :video_ext
    t.remove :pics
    end
  end

  def self.down
    change_table :talks do |t|
      t.string :video_ext
    t.string :pics
    end
  end
end
