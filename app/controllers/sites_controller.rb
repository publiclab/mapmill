class SitesController < ApplicationController

  def create
    #TODO check session 
    # if not login
    site = Sitetmp.new
    # TODO nounce = generate_nonce
    site.save
    #TODO redirect to login
    redirect_to '/login' 
  end 


  def upload

  end


end
