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


  def show
    @site= Site.find(params[:id])
  end

  def sites
    @sites = Site.all
  end


  def upload
    @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: 201, acl: :public_read)
    @s3_post_data = {"data-url" => @s3_direct_post.url, "data-fields" => @s3_direct_post.fields.to_json.html_safe, "data-host" => @s3_direct_post.url.host}
  end

  private#
  def nonce
    return rand(10 ** 30).to_s.rjust(30,'0')
  end 

end
