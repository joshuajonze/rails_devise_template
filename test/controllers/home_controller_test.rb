require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_path
    assert_response :success
    assert_select "h1", "Welcome to Rails Devise Template"
  end
end