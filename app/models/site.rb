class Site < ActiveRecord::Base

	 validates_presence_of :user_id, :name, :url
  	 
	belongs_to :user
end
