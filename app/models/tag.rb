class Tag < ActiveRecord::Base

	has_many :taggings
	has_many :talks, :through => :taggings
	has_many :people, :through => :taggings
end
