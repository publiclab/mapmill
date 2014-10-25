
class ImagesController < ApplicationController

  # POST /image
  # POST /images.json
  def create
    @site = Site.find(params[:site_id])
    @image = @site.images.create(image_params)
    respond_to do |format|
      #format.js {render nothing: true}
      format.js {render json: @image.to_json, status: :created}
    end
  end

  def show
    @image = Image.find(params[:id])
    respond_to do |format|
      format.js {render json: @image.to_json, status: :ok}
    end
  end


  def set_thumbnail
    @image = Image.find(params[:id])
    @image.thumbnail = params[:thumbnail]
    @image.save
    respond_to do |format|
      format.js {render json: @image.to_json, status: :ok}
    end
  end

  def set_good
    set_quality(1)
  end

  def set_nok
    set_quality(2)
  end

  def set_bad
    set_quality(3)
  end

  private
    def image_params
      params.permit(:url, :thumbnail)
    end

    def set_quality(val)
      @image = Image.find(params[:id])
      @vote = @image.votes.create
      @vote.value = val 
      @vote.ip = request.remote_ip
      if @vote.save!
        votes = Vote.find_by_image(@image) 
        sum = 0
        if votes
          votes.each do |vote|
            sum += vote.value
          end
          cnt = votes.length 
          avg = sum.fdiv(cnt)
          case avg
          when 0..1.5 
            @image.good!
          when 1.5..2.5
            @image.nok!
          when 2.5..3
            @image.bad!
          else
            #nothing
          end 
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
end
