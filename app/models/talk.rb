class Talk < ActiveRecord::Base

	#Don't use carrierwave for video uploads!
	#mount_uploader :video, VideoUploader
	
	mount_uploader :thumb, ThumbnailUploader
	mount_uploader :slides, SlidesUploader

	has_many :sponsorships
	has_many :sponsors, :through => :sponsorships
	has_many :taggings
	has_many :tags, :through => :taggings
	has_many :speakers
	has_many :people, :through => :speakers

	def search(term)
		#TODO: Improve this search
		return Talk.where "title like '%#{term}%' or s_descrip like '%#{term}%' or l_descrip like '%#{term}%'"
	end
end
