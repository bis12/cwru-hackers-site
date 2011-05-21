class Talk < ActiveRecord::Base

	mount_uploader :video, VideoUploader

	belongs_to :account
end
