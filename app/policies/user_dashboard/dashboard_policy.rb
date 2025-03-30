# frozen_string_literal: true

module UserDashboard
  class DashboardPolicy < ApplicationPolicy
    # The dashboard policy is different because it doesn't have a specific record
    # Instead, we'll check if the user is allowed to access the dashboard at all
    
    class Scope < Scope
      def resolve
        scope.all
      end
    end
  
    def index?
      # Only authenticated users can access the dashboard
      user.present?
    end
  end
end 