class ProfilesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    authorize :profile, :index?
  end
end 