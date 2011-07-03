class AdminController < ApplicationController

	def index
		@sites = Site.find(:all,:order => "created_at DESC")
	end

	def archive
		@site = Site.find params[:id]
		@site.active = false
		@site.save
		redirect_to "/admin"
	end
	
	def activate
		@site = Site.find params[:id]
		@site.active = true
		@site.save
		redirect_to "/admin"
	end

	def import
		Site.import
		Site.find(:all).each do |site|
			site.import_images
		end
		render :text => "import successful"
	end

end
