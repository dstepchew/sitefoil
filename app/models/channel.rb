class Channel < ActiveRecord::Base

	has_many :triggers
  	has_many :recipes
  	has_many :acts
 

  	accepts_nested_attributes_for :triggers, :allow_destroy => true
  	accepts_nested_attributes_for :acts, :allow_destroy => true

end
