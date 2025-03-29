# frozen_string_literal: true

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
  
    def show?
      user.present? && (user == record || user.admin?)
    end
  
    def update?
      user.present? && (user == record || user.admin?)
    end
  
    def destroy?
      user.present? && user.admin? && user != record
    end
  end