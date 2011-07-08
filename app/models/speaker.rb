class Speaker < ActiveRecord::Base

	belongs_to :talk
	belongs_to :person

end
