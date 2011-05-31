class Sponsorship < ActiveRecord::Base

	belongs_to :talk
	belongs_to :sponsor
end
