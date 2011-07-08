class Person < ActiveRecord::Base

	mount_uploader :pic, PicUploader

	has_many :taggings
	has_many :tags, :through => :taggings
	has_many :speakers
	has_many :talks, :through => :speakers
end
