# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.

# Create a default user for testing
if Rails.env.development?
    User.find_or_create_by(email: 'test@example.com') do |user|
      user.password = 'password'
      user.password_confirmation = 'password'
      puts 'Default user created: test@example.com / password'
    end
  end