class MapperController < ApplicationController

	def sites
		@sites = Site.find :all, :conditions => {:active => true}
	end

	def images
		site = Site.find_by_name(params[:site])
		# sort by the highest rating -- the ratio
		@images = site.images.sort_by do |i|
			if (i.hits > 0)
				-1*i.points/i.hits
			else
				0
			end
		end
		@images = @images.paginate :per_page => 20, :page => params[:page]
		#@images.paginate :page => params[:page], :per_page => 21
	end

	# currently collects 5 lowest vote-count images from each site,
	# removing thumb dirs, from the end of the list, alphabetically? dumb.
	def index
		pool = []
		# this'll get expensive... try getting a random site?
		Site.find(:all,:conditions => {:active => true}).each do |site|
			pool = pool + site.voted_less_than(5,5) # five images with less than 5 votes
		end

		@image = pool[((pool.length-1)*rand).to_i]
		@image.thumb
	end

	def import
		Site.import
		Site.find(:all).each do |site|
			site.import_images
		end
		render :text => "import successful"
	end

	def sort
		@site = Site.find_by_name(params[:site])
		pool = []
		# this'll get expensive... try getting a random site?
		pool = @site.voted_less_than(5,5) # five images with less than 5 votes

		@image = pool[((pool.length-1)*rand).to_i]
		@image.thumb
		@sitename = @site.name
		render "index"
	end

	def vote
		if i = Image.find(params[:id])
			i.points += params[:points].to_i if params[:points].to_i < 11
			i.vote
		end
		if params[:site] != ""
			path = '/sort/'+params[:site]+'/?o=x&last='+i.path
		else
			path = '/?o=x&last='+i.path
		end
		redirect_to path
	end
	
	def save_site_location
		redirect_to 'sites'
	end

	def locate_site
		@site = Site.find_by_name(params[:site])
		@image = @site.images.first
		@image.thumb
		render "locate"
	end

	def locate_image
		render "locate"
	end

	def geolocate
		begin
        		location = GeoKit::GeoLoc.geocode(params[:id])
        		render :text => location.lat.to_s+","+location.lng.to_s
		rescue
			render :text => "No results"
		end
	end

end
