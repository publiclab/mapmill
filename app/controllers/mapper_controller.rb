class MapperController < ApplicationController

	def sites
		sites = []
		dirs = Dir.new('public/sites')
		dirs.each do |dir|
			sites << 'sites/'+dir if dir[-6..-1] != '_thumb' && dir[0..0] != '.' 
		end
		@sites = []
		sites.each do |site|
			d = Dir.new(RAILS_ROOT+'/public/'+site)	
			images = []
			d.each do |file|
				images << file if file[-3..-1] == 'jpg'
			end
			@sites << [site,images.length]
		end
	end

	def best
		@path = params[:path][0..(-1*params[:path].split('/').last.length)]
		images = Image.find :all, :conditions => ['path LIKE ?',@path+'%']
		@images = images.sort_by do |i| 
			if (i.hits > 0)
				-1*i.points/i.hits
			else
				0
			end
		end
	end

end
