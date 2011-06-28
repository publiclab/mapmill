class AdminController < ApplicationController

	def index
		@sites = Site.find(:all)
	end

	def archive
		@site = Site.find params[:id]
		@site.active = false
		@site.save
	end
	
	def activate
		@site = Site.find params[:id]
		@site.active = true
		@site.save
	end

end
