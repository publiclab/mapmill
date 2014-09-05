class SessionController < ApplicationController

  @@openid_url_base  = "http://publiclaboratory.org/people/"


  def login_openid
    openid_url = @@openid_url_base + "faboolous" + "/identity"
    openid_authentication(openid_url)
  end

#  protected

  def openid_authentication(openid_url)
    puts openid_url
    authenticate_with_open_id(openid_url, :required => [:nickname, :email]) do |result, identity_url, registration|
      if result.successful?
        @user = User.find_by_identity_url(identity_url)
        if not @user
          @user = User.new
          @user.username = registration['nickname']
          @user.email = registration['email']
          @user.identity_url = identity_url
          @user.save
          nonce = params[:n]
          if nonce? 
            @tmp = Sitetmp.find_by nonce: nonce
            @site = Site.new(tmp)
            @site.save
            @tmp.destroy
          end
        end
        @current_user = @user
        successful_login
      else
        failed_login result.message
        return false
      end
    end
  end

  def failed_login(message = "Authentication failed.")
    flash.now[:error] = message
    redirect_to '/'
  end

  def successful_login
    session[:user_id] = @current_user.id
    redirect_to '/sites/upload'
  end

  def logout
    session[:user_id] = nil 
    redirect_to '/'
  end

end

