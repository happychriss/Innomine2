class ApplicationController < ActionController::Base

  before_action :current_user

  private

  def current_user
    if session[:user_id].nil?
      @user = User.first
    else
      @user = User.find(session[:user_id])
    end
  end


end
