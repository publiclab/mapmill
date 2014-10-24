
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
            puts "set quality"
            @image = Image.find(params[:id])
            vote = Vote.new
            vote.value = val 
            if vote.save!
              puts "vote saved"
              votes = Vote.find_by_image(@image.id) 
              sum, cnt = 0
              votes.each do |value|
                cnt += 1
                sum += value
              end
              avg = (sum / cnt).round
              puts "avg: " + avg
              case
              when 1
                puts "good!"
                @image.good!
              when 2
                puts "nok"
                @image.nok!
              when 3
                puts "bad"
                @image.bad!
              else
                #nothing
              end 
              @image.save
            else
               puts "could not save vote"
            end
            respond_to do |format|
              format.js {render nothing: true}
            end
    end
end
