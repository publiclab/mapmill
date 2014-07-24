class SitesController < ApplicationController

  @@openid_url_base  = "http://publiclaboratory.org/people/"
  def create
    openid_url = @@openid_url_base + "faboolous" + "/identity"
    openid_authentication(openid_url)
  end 

#  protected

  def openid_authentication(openid_url)
    puts openid_url
    authenticate_with_open_id(openid_url, :required => [:nickname, :email]) do |result, identity_url, registration|
      if result.successful?
         puts "true"
         redirect_to 'sites/upload'
         return true
=begin
        @user = User.find_or_initialize_by_identity_url(identity_url)
        if @user.new_record?
          @user.login = registration['nickname']
          @user.email = registration['email']
          @user.save(false)
        end
        self.current_user = @user
        successful_login
=end
      else
        puts "false"
        failed_login result.message
        return false
      end
    end
  end

  def failed_login(message = "Authentication failed.")
    flash.now[:error] = message
    render :action => 'new'
  end

end
