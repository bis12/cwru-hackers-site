class AddFieldsToAccounts < ActiveRecord::Migration
  def self.up
    change_table :accounts do |t|
      t.string :vid_api_key
    end
  end

  def self.down
    change_table :accounts do |t|
      t.remove :vid_api_key
    end
  end
end
