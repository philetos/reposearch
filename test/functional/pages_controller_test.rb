require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  should "have a home page" do
    get :home
    assert_response :success
  end
end
