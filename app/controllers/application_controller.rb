class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :current_user

  def current_user
    user_id = session[:user_id] 
    if user_id
      begin
        @user = User.find(user_id)
      rescue
        @user = nil
      end
    else
      @user = nil
    end
  end
end
