# frozen_string_literal: true

module UserManagement
  class Policy < ApplicationPolicy
    class Scope < Scope
      def resolve
        if user&.admin?
          scope.all
        else
          scope.where(id: user.id)
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
  
    def edit?
      user.present? && (user == record || user.admin?)
    end
  
    def update_password?
      user.present? && user == record
    end
  
    def update_email?
      user.present? && user == record
    end
  
    def update_profile?
      user.present? && user == record
    end
  
    def confirm?
      user.present? && user == record
    end
  
    def resend_confirmation?
      user.present? && user == record
    end
  end
end 