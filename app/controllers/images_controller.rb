
class ImagesController < ApplicationController

  # POST /image
  # POST /images.json
  def create
    @site = Site.find(params[:site_id])
    @image = @site.images.create(image_params)
    respond_to do |format|
      format.js {render nothing: true}
    end
  end


  private
    def image_params
      params.permit(:url, :thumbnail)
    end
end
