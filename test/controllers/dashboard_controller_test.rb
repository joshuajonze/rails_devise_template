require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  setup do
    @user = User.create!(email: "dashboard_test@example.com", 
                        password: "password", 
                        password_confirmation: "password")
  end

  test "should redirect to sign in when not authenticated" do
    get dashboard_path
    assert_redirected_to new_user_session_path
  end
  
  test "should get dashboard when authenticated" do
    sign_in @user
    get dashboard_path
    assert_response :success
    assert_select "h1", "Dashboard"
  end
end