class Act < ActiveRecord::Base

	belongs_to :recipe
	belongs_to :channel
	has_many :ingredients
end
