class ProfilePolicy < ApplicationPolicy
  def index?
    user.present?
  end
end 