require 'uri'

class SitesController < ApplicationController

  before_action :require_login, only: [:upload]

  def create
    user_id = session[:user_id] 
    if User.exists?(user_id)
      site = Site.new
      site.save
      redirect_to '/sites/upload'
    else 
      open_id = URI.encode(params[:open_id])
      site = Sitetmp.new
      site.nonce = nonce
      site.save
      to_url = '/login?n='  + nonce + '&open_id=' + open_id
      redirect_to to_url 
    end
  end 


  def upload

  end

  private
  def nonce
    return rand(10 ** 30).to_s.rjust(30,'0')
  end 
end
