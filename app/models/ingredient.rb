class Ingredient < ActiveRecord::Base
	belongs_to :trigger
	belongs_to :act

end
