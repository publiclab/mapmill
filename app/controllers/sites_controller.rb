class SitesController < ApplicationController

  def create
    user_id = session[:user_id] 
    if User.exists?(user_id)
      site = Site.new
      site.save
      redirect_to '/sites/upload'
    else 
      site = Sitetmp.new
      site.nonce = nonce
      site.save
      redirect_to '/login?n='  + nonce
    end
  end 


  def upload

  end

  private
  def nonce
    return rand(10 ** 30).to_s.rjust(30,'0')
  end 
end
