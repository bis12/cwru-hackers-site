class Talk < ActiveRecord::Base

	#Don't use carrierwave for video uploads!
	#mount_uploader :video, VideoUploader

	belongs_to :account
	has_many :sponsorships
	has_many :sponsors, :through => :sponsorships
end
