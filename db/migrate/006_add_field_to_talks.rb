class AddFieldToTalks < ActiveRecord::Migration
  def self.up
    change_table :talks do |t|
      t.string :video_ext
    end
  end

  def self.down
    change_table :talks do |t|
      t.remove :video_ext
    end
  end
end
