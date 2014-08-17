class SitesController < ApplicationController

  @@openid_url_base  = "http://publiclaboratory.org/people/"

  def create
    @trust_root = 'http://localhost:3000/'
    @return_to = 'http://localhost:3000/sites/complete_open_id'
    openid_url = @@openid_url_base + "faboolous" + "/identity"
    OpenID::Consumer::CheckIDRequest.redirect_url(@trust_root,@return_to)
    openid_authentication(openid_url)
  end 

  def complete_open_id
    
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
