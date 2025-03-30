# frozen_string_literal: true

module Admin
  class UserPolicy < ApplicationPolicy
    class Scope < Scope
      def resolve
        if user&.admin?
          scope.all
        else
          scope.none
        end
      end
    end

    def index?
      user.present? && user.admin?
    end

    def show?
      user.present? && user.admin?
    end

    def create?
      user.present? && user.admin?
    end

    def update?
      user.present? && user.admin? && user != record
    end

    def destroy?
      user.present? && user.admin? && user != record
    end

    def toggle_admin?
      user.present? && user.admin? && user != record
    end

    def reset_password?
      user.present? && user.admin? && user != record
    end

    def lock?
      user.present? && user.admin? && user != record
    end

    def unlock?
      user.present? && user.admin? && user != record
    end
  end
end 