require "application_system_test_case"

class AuthenticationTest < ApplicationSystemTestCase
  test "visiting the home page" do
    visit root_path
    
    assert_selector "h1", text: "Welcome to Rails Devise Template"
    assert_selector "a", text: "Sign in"
    assert_selector "a", text: "Sign up"
  end
  
  test "signing up with valid information" do
    visit new_user_registration_path
    
    assert_selector "h2", text: "Create an Account"
    
    fill_in "Email", with: "newuser@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    
    click_on "Sign up"
    
    assert_text "Welcome"
    assert_selector "h1", text: "Dashboard"
  end
  
  test "signing up with invalid information" do
    visit new_user_registration_path
    
    fill_in "Email", with: "invalid-email"
    fill_in "Password", with: "pass"
    fill_in "Password confirmation", with: "word"
    
    click_on "Sign up"
    
    assert_text "Email is invalid"
    assert_text "Password is too short"
    assert_text "Password confirmation doesn't match Password"
  end
  
  test "signing in with valid information" do
    # Create a real user instead of relying on fixtures
    User.create!(email: "testuser@example.com", password: "password", password_confirmation: "password")
    
    visit new_user_session_path
    
    fill_in "Email", with: "testuser@example.com"
    fill_in "Password", with: "password"
    
    click_on "Sign in"
    
    assert_selector "h1", text: "Dashboard"
  end
  
  test "signing in with invalid information" do
    visit new_user_session_path
    
    fill_in "Email", with: "wrong@example.com"
    fill_in "Password", with: "wrongpassword"
    
    click_on "Sign in"
    
    assert_text "Invalid Email or password"
  end
  
  test "signing out" do
    # Create a real user
    User.create!(email: "signout_test@example.com", password: "password", password_confirmation: "password")
    
    # First sign in
    visit new_user_session_path
    fill_in "Email", with: "signout_test@example.com"
    fill_in "Password", with: "password"
    click_on "Sign in"
    
    # Then sign out
    click_on "Sign out"
    
    assert_selector "a", text: "Sign in"
    assert_selector "a", text: "Sign up"
  end
end