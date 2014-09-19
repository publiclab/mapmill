
class SitesController < ApplicationController

  # POST /image
  # POST /images.json
  def create
    @image = Image.new(params[:image])

    respond_to do |format|
      if @image.save
        format.html { redirect_to @image, notice: 'Photo was successfully created.' }
        format.json {
          data = {id: @image.id, thumb: view_context.image_tag(@image.image.url(:thumb))}
          render json: data, status: :created, location: @image
        }
      else
        format.html { render action: "new" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end
end
