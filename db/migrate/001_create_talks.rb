class CreateTalks < ActiveRecord::Migration
  def self.up
    create_table :talks do |t|
      t.string :title
      t.string :speaker
      t.date :date
      t.string :s_descrip
      t.string :l_descrip
      t.string :thumb
      t.string :pics
      t.string :video
      t.string :slides
    end
  end

  def self.down
    drop_table :talks
  end
end
