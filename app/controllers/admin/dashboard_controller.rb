module Admin
    class DashboardController < ApplicationController
      before_action :authenticate_user!
      
      def index
        authorize :admin_dashboard, :index?
        @users = policy_scope(User)
      end
    end
  end