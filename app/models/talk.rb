class Talk < ActiveRecord::Base

	#Don't use carrierwave for video uploads!
	#mount_uploader :video, VideoUploader

	belongs_to :account
	has_many :sponsorships
	has_many :sponsors, :through => :sponsorships


	def attach_video(video, params)
	    if not video.nil?
		    #TODO: ok, something must be fixable about this crazy situation we've got going on here...
		    #Also, move all of this to a delayed job, so that the server is not locked up!
		    vid_file = File.open(video[:tempfile])
		    saved = File.open("uploads/#{video[:filename]}", 'wb')
		    saved.write(vid_file.read)
		    saved = File.open("uploads/#{video[:filename]}", 'rb')
		    blip = BlipTV::Base.new 
		    uploaded = blip.upload_video({
			    :title => params[:talk][:title],
			    :file =>  saved,
			    :username => APP_KEYS["bliptv"]["uname"],
			    :password => APP_KEYS["bliptv"]["pass"]})
		    return uploaded.id
	    end

	    return nil
	end
end
