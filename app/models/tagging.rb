class Tagging < ActiveRecord::Base

	belongs_to :talk
	belongs_to :person
	belongs_to :tag

end
