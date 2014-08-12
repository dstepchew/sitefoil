require 'test_helper'

class SiteTest < ActiveSupport::TestCase

	test "should check if selector exist" do
		assert Site::selector_exists "<body><div id=some></div></body>", "#some"
		assert !(Site::selector_exists "<body><div id=some></div></body>", "#wrong")
	end
end
