require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    # Create a user with a unique email for each test
    @user = User.new(email: "user_#{Time.now.to_i}@example.com", 
                    password: "password", 
                    password_confirmation: "password")
  end
  
  test "should be valid" do
    assert @user.valid?
  end
  
  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end
  
  test "email should be valid" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. 
                          foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  test "email addresses should be unique" do
    # Create a user with a specific email
    test_email = "unique_test_#{Time.now.to_i}@example.com"
    User.create!(email: test_email, 
                password: "password", 
                password_confirmation: "password")
    
    # Create a duplicate with the same email
    duplicate_user = User.new(email: test_email, 
                             password: "different", 
                             password_confirmation: "different")
    assert_not duplicate_user.valid?
  end
  
  test "email addresses should be saved as lowercase" do
    # Create a user with a mixed-case email
    mixed_case_email = "MiXeD_CaSe_#{Time.now.to_i}@ExAmPlE.CoM"
    user = User.new(email: mixed_case_email, 
                   password: "password", 
                   password_confirmation: "password")
    user.save!
    assert_equal mixed_case_email.downcase, user.reload.email
  end
  
  test "password should be present" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end
  
  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end