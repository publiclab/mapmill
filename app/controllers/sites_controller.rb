require 'uri'

class SitesController < ApplicationController

  before_action :require_login, only: [:upload]

  def create
    user_id = session[:user_id] 
    if user_id 
      all_params = site_params
      all_params[:date] = Date.strptime(all_params[:date],'%m/%d/%Y') 
      site = Site.new(all_params)
      if site.valid?
        site.save
        redirect_to '/sites/' + site.id.to_s + '/upload'
      else
        err = site.errors.messages
        err_str = "\n"
        err.each do |key, value|
          err_str += "#{key}:#{value}\n"
        end
        flash[:error] = "Oooops - sorry, something went wrong while saving your new site: " + err_str
        redirect_to '/'
      end
    else 
      open_id = URI.encode(params[:open_id])
      tmp = Sitetmp.new(site_params)
      tmp.nonce = nonce
      tmp.save
      to_url = '/login?n='  + tmp.nonce + '&open_id=' + open_id
      redirect_to to_url 
    end
  end 


  def show
    @ip = request.remote_ip
    @site= Site.find(params[:id])
    @votes = {}
    @site.images.each do | img |
      @votes[img.id] = Vote.where(image: img)  
    end
  end

  def index 
    @sites = Site.all
  end


  def upload
    @site = Site.find(params[:id])
    @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: 201, acl: :public_read)
    @s3_post_data = {url: @s3_direct_post.url, fields: @s3_direct_post.fields.to_json.html_safe, host: @s3_direct_post.url.host}
  end

  private#
  def nonce
    return rand(10 ** 30).to_s.rjust(30,'0')
  end 

  def site_params
    params.require(:site).permit(:name,:date,:description)
  end

end
