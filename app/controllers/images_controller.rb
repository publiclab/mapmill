
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


  def set_thumbnail
    @image = Image.find(params[:id])
    @image.thumbnail = params[:thumbnail]
    @image.save
    respond_to do |format|
      format.js {render json: @image.to_json, status: :ok}
    end
  end


  private
    def image_params
      params.permit(:url, :thumbnail)
    end
end
