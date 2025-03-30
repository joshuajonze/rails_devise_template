# frozen_string_literal: true

module Admin
  class DashboardPolicy < ApplicationPolicy
    class Scope < Scope
      def resolve
        scope.all
      end
    end
  
    def index?
      user.present? && user.admin?
    end
  end
end 