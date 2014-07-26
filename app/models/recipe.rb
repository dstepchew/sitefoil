class Recipe < ActiveRecord::Base

	 has_one :trigger
	# has_one :channels, through :trigger
	 has_one :act

	 belongs_to :site
end
