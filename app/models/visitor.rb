# == Schema Information
#
# Table name: visitors
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

class Visitor < ActiveRecord::Base
	has_many :hits
end
