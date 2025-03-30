module UserManagement
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
  end
end 