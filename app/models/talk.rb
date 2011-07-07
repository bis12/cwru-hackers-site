class Talk < ActiveRecord::Base

	#Don't use carrierwave for video uploads!
	#mount_uploader :video, VideoUploader
	
	mount_uploader :thumb, ThumbnailUploader
	mount_uploader :slides, SlidesUploader

	has_many :sponsorships
	has_many :sponsors, :through => :sponsorships
	has_many :taggings
	has_many :tags, :through => :taggings


end
