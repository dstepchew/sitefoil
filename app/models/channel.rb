# == Schema Information
#
# Table name: channels
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  status      :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Channel < ActiveRecord::Base

	has_many :triggers
  	has_many :recipes
  	has_many :acts
 

  	accepts_nested_attributes_for :triggers, :allow_destroy => true
  	accepts_nested_attributes_for :acts, :allow_destroy => true

end
