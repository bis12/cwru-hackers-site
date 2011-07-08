class RemoveFieldsFromTalk < ActiveRecord::Migration
  def self.up
	 change_table :talks do |t|
		t.remove :speaker
	 end	
  end

  def self.down
	 change_table :talks do |t|
		t.string :speaker
	 end	
  end
end
