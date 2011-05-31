class Sponsor < ActiveRecord::Base

	mount_uploader :logo, LogoUploader

	has_many :sponsorships
	has_many :talks, :through => :sponsorships

	validates_presence_of :name
end
