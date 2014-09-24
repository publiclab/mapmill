require 'uri'

class SitesController < ApplicationController

  before_action :require_login, only: [:upload]

  def create
    user_id = session[:user_id] 
    if user_id 
      @site = Site.new(site_params)
      @site.save
      redirect_to '/sites/' + @site.id + '/upload'
    else 
      open_id = URI.encode(params[:open_id])
      @tmp = Sitetmp.new(site_params)
      @tmp.nonce = nonce
      @tmp.save
      to_url = '/login?n='  + @tmp.nonce + '&open_id=' + open_id
      redirect_to to_url 
    end
  end 


  def show
    @site= Site.find(params[:id])
  end

  def sites
    @sites = Site.all
  end


  def upload
    @site = Site.find(params[:id])
    @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: 201, acl: :public_read)
    @s3_post_data = {url: @s3_direct_post.url, fields: @s3_direct_post.fields.to_json.html_safe, host: @s3_direct_post.url.host}
    #@s3_post_data = {url: "http://localhost:8088"}
  end

  private#
  def nonce
    return rand(10 ** 30).to_s.rjust(30,'0')
  end 

  def site_params
    params.require(:site).permit(:name, :date, :description)
  end

end
