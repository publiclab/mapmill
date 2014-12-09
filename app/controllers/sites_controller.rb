require 'uri'

class SitesController < ApplicationController

  before_action :require_login, only: [:upload]

  ##############################################################
  # Create a new site
  #
  # As the UI is on the front home page for site creation,
  # and login is required for site creation,
  # and only allowed login mechanism is PublicLab's
  # OpenID, we need to create a temprary object
  # (Sitetmp) if the user is not logged in, in order 
  # to redirect to the OpenID provider. A nonce 
  # is generated and sent as GET parameter.
  # If Login went successful, the nonce is passed again
  # and the real site object is created
  ##############################################################
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
        flash[:danger] = "Oooops - sorry, something went wrong while saving your new site: " + err_str
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

  ##############################################################
  # Map view of a site
  ##############################################################
  def map
    @site = Site.find(params[:id])

    @max_lat = 0
    @max_lng = 0
    @min_lat = 0
    @min_lng = 0
    @center_lat = 0
    @center_lng = 0

    @markers = []

    render layout: "map"
  end

  ##############################################################
  # Show a site
  ##############################################################
  def show
    # If an image has been voted, we need to disable voting, this is done via cookie
    @cookie = cookies["_mapmill_voting_"]
    begin
      @site= Site.find(params[:id])
    rescue
      flash[:danger] = "The requested site does not exist in the system."
      redirect_to sites_path 
      return
    end
    @votes = {}
    @site.images.each do | img |
      @votes[img.id] = Vote.where(image: img)  
    end
  end

  def index 
    @sites = Site.all
  end


  ##############################################################
  # Upload view, in order to upload images
  ##############################################################
  def upload
    begin
      @site = Site.find(params[:id])
    rescue
      puts "Requested site id " + params[:id] + " not found"
      flash[:danger] = "The requested site does not exist in the system."
      redirect_to sites_path 
      return
    end

    # AWS S3 parameters which will be encoded in the jquery fileupload widget
    # This is important stuff as it is the security part allowing the upload to succeed
    @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: 201, acl: :public_read)
    @s3_post_data = {url: @s3_direct_post.url, fields: @s3_direct_post.fields.to_json.html_safe, host: @s3_direct_post.url.host}
  end

  ##############################################################
  # Private methods
  ##############################################################
  private
  ##############################################################
  # Generate a nonce
  ##############################################################
  def nonce
    return rand(10 ** 30).to_s.rjust(30,'0')
  end 

  def site_params
    params.require(:site).permit(:name,:date,:description)
  end

end
