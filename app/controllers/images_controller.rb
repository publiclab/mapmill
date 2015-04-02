
class ImagesController < ApplicationController

  def create
    if only_xhr
      return
    end      
    @site = Site.find(params[:site_id])
    @image = @site.images.create(image_params)
    respond_to do |format|
      format.js {render json: @image.to_json, status: :created}
    end
  end

  def show
    if only_xhr
      return
    end      
    begin 
     @image = Image.find(params[:id])
    rescue
      respond_to do |format|
        format.js {render :nothing => true, status: :not_found}
      end
    end
    @voting_disabled = false
    votes = Vote.find_by_image(@image)
    if votes
      votes.each do | v |
        if v.cookie == get_cookie_id()
          @voting_disabled = true
        end
      end
    end
    
    response = { :image => @image, :voting_disabled => @voting_disabled }
    respond_to do |format|
      format.js {render :json => response, status: :ok}
    end
  end
  
  def set_thumbnail
    if only_xhr
      return
    end      
    begin
      @image = Image.find(params[:id])
      @image.thumbnail = params[:thumbnail]
      @image.save
      respond_to do |format|
        format.js {render json: @image.to_json, status: :ok}
      end
    rescue
      respond_to do |format|
        format.js {render :nothing => true, status: :not_found}
      end
    end
  end

  def set_good
    set_quality(2)
  end

  def set_nok
    set_quality(1)
  end

  def set_bad
    set_quality(0)
  end

  private
    def image_params
      params.permit(:url, :thumbnail, :lat, :lng)
    end
	
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
	
	def set_quality(val)
      if only_xhr
        return
      end      
      @image = Image.find(params[:id])
      @vote = @image.votes.create
      @vote.value = val 
	  
      # store vote id via cookie
      @vote.cookie = get_cookie_id()
     
      # update image "quality" by averaging votes
      if @vote.save!
        votes = Vote.find_by_image(@image) 
        sum = 0
        if votes
          votes.each do |vote|
            sum += vote.value
          end
          cnt = votes.length 
          @image.quality = 1.00*sum/cnt
          @image.save
        else
          msg = "Error accessing votes: No votes found!"
          puts msg
          format.json { render :text => msg, :status => 404 }
        end
      else
        msg = "could not save vote"
        puts msg
        format.json { render :text => msg, :status => 500 }
      end
      respond_to do |format|
        format.json {render json: @image}
      end
    end


    def only_xhr
      if !request.xhr?
        render_404
        return true 
      else
        return false 
      end 
    end
end
