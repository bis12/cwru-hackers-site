class Talk < ActiveRecord::Base

	#Don't use carrierwave for video uploads!
	#mount_uploader :video, VideoUploader
	
	mount_uploader :thumb, ThumbnailUploader

	belongs_to :account
	has_many :sponsorships
	has_many :sponsors, :through => :sponsorships


end
