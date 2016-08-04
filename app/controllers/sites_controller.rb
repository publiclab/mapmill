require 'uri'
require 'will_paginate/array'

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
  #Full Screen view of a site
  ##############################################################
  def fullscreen
  @site = site.find(params[:id])
  end
  
  ##############################################################
  #Get the cookie value
  ##############################################################
	def get_cookie_id
		ckey = "_mapmill_voting_"
		if cookies[ckey]
			return cookies[ckey]
		else
			cookie_id = SecureRandom.base64 
			cookies[ckey] = cookie_id
			return cookie_id
		end
	end
  
  ##############################################################
  # Show a site
  ##############################################################
  def show
    # If an image has been voted, we need to disable voting, this is done via cookie
    @site = Site.find(params[:id])
	
	cookie_id = get_cookie_id()
	seed_final = cookie_id.gsub(/[^0-9]/, "").to_i		#turn this string into integer w/only numbers included
	orderimg = Image.where('custom != 0').order('custom asc') 
	randimg = Image.where('custom == 0').order('id asc').shuffle(random: Random.new(seed_final))
	@images = orderimg.push(*randimg)
    @images = @images.paginate(:page => params[:page], :per_page => 24) unless @images.nil?
    @images ||= []
    @votes = {}
    @images.each do | img |
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
    s3_secure = (S3_DEV_PROTOCOL != 'http')
    @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: 201, acl: :public_read, secure: s3_secure)
    if S3_DEV_HOST
      s3_url = S3_DEV_PROTOCOL + '://' + S3_BUCKET.name() + '.' + S3_DEV_HOST + ':' + S3_DEV_PORT + '/'
    else
      s3_url = @s3_direct_post.url
    end
    @s3_post_data = {url: s3_url, fields: @s3_direct_post.fields.to_json.html_safe, host: @s3_direct_post.url.host}
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
