class SitesController < ApplicationController

  @@openid_url_base  = "publiclaboratory.org/people/"

  def create
    @site = Site.new(site_params)
    openid_url = @@openid_url_base + "faboolous" + "/identity"
    auth = openid_authentication(openid_url)
    redir = :root
    if auth == true
      @site.save
      puts sites_path 
      redir = sites_path + "/" + @site.id + "/upload"    
      puts redir
    redirect_to redir
  end 

  protected

  def openid_authentication(openid_url)
    authenticate_with_open_id(openid_url, :required => [:nickname, :email]) do |result, identity_url, registration|
      if result.successful?
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
        failed_login result.message
        return false
      end
    end
  end

  def failed_login(message = "Authentication failed.")
    flash.now[:error] = message
  end

  private
  
  def site_params
    params.require(:site).permit(:name,:date,:description)
  end

end
