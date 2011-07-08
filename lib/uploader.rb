class DefaultImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or ImageScience support:
  include CarrierWave::RMagick
  # include CarrierWave::ImageScience

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
     "/images/default.png"
  end

  # Process files as they are uploaded:
  process :resize_to_fill => [200, 200]
  process :convert => 'png'
 
  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  #def extension_white_list
  #  %w(jpg jpeg gif png)
  #end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # TODO: improve file naming convention
  def filename
  	  @name ||= "#{model.id}_#{secure_token}.png"
  end
 
  def secure_token
    ivar = "@#{mounted_as}_secure_token"
    token = model.instance_variable_get(ivar)
    token ||= model.instance_variable_set(ivar, ActiveSupport::SecureRandom.hex(4))  
  end
end

class LogoUploader < DefaultImageUploader 

  # Override the directory where uploaded files will be stored.
  def store_dir
    "uploads/logos/"
  end
end

class ThumbnailUploader < DefaultImageUploader
 
  # Override the directory where uploaded files will be stored.
  def store_dir
    "uploads/thumbs/"
  end
end

class PicUploader < DefaultImageUploader
 
  # Override the directory where uploaded files will be stored.
  def store_dir
    "uploads/users/"
  end

  version :thumb do
    process :resize_to_fill => [40,40]
  end
end


class SlidesUploader < CarrierWave::Uploader::Base

  # Include RMagick or ImageScience support:
  # include CarrierWave::RMagick
  # include CarrierWave::ImageScience

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/slides/"
  end

  # Add a white list of extensions which are allowed to be uploaded.
  def extension_white_list
    %w(pdf)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # TODO: improve file naming convention
  #def filename
  # 	  @name ||= "#{model.id}_#{secure_token}.png"
  #end
 
  #def secure_token
  #  ivar = "@#{mounted_as}_secure_token"
  #  token = model.instance_variable_get(ivar)
  #  token ||= model.instance_variable_set(ivar, ActiveSupport::SecureRandom.hex(4))  
  #end

end
