class AddFieldToAccounts < ActiveRecord::Migration
  def self.up
    change_table :accounts do |t|
      t.string :vid_uname
    t.string :vid_pass
    end
  end

  def self.down
    change_table :accounts do |t|
      t.remove :vid_uname
    t.remove :vid_pass
    end
  end
end
