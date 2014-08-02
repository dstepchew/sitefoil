# == Schema Information
#
# Table name: ingredients
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Ingredient < ActiveRecord::Base
	belongs_to :trigger
	belongs_to :act

end
