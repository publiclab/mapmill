class MapperController < ApplicationController
	def sites
		@sites = Site.all
	end

	def images
		images = Image.find :all, :conditions => ['path LIKE ?','sites/'+params[:site]+'%'], :limit => 10
		@images = images.sort_by do |i|
			if (i.hits > 0)
				-1*i.points/i.hits
			else
				0
			end
		end
		@images = @images.paginate :per_page => 20, :page => params[:page]
		#@images.paginate :page => params[:page], :per_page => 21
	end

	def index
		pool = []
		Dir.new('public/sites').each do |site|
			if site[-6..-1] != '_thumb' && File.directory?('public/sites/'+site)
				d = Dir.new(RAILS_ROOT+'/public/sites/'+site)
				d.each do |image|
					if image[-3..-1] && image[-3..-1].downcase == 'jpg' && site+'/'+image != params[:last]
						pool << 'sites/'+site+'/'+image
					end
				end
			end
		end
		small_pool = []

		1..5.times do
			rand_index = ((pool.length-1)*rand).to_i
			puts pool.length.to_s+' images, selected '+rand_index.to_s
			image = pool.slice(rand_index,1).first
			unless Image.find_by_path(image)
				i = Image.new({:path => image,:filename => image.split('/').last})
				i.save
			end
			if i = Image.find_by_path(image)
				small_pool << image if i.hits < 5
			end
		end
		small_pool << pool[((pool.length-1)*rand).to_i] if small_pool.length < 1
		@image = Image.find(:all,:conditions => ['path IN (?)',small_pool],:order => 'hits DESC',:limit => 1).first
		@image.thumb
	end

	def sort
		pool = []
		site = params[:site]
			if site[-6..-1] != '_thumb' && File.directory?('public/sites/'+site)
				d = Dir.new(RAILS_ROOT+'/public/sites/'+site)
				d.each do |image|
					if image[-3..-1] && image[-3..-1].downcase == 'jpg' && site+'/'+image != params[:last]
						pool << 'sites/'+site+'/'+image
					end
				end
			end
		small_pool = []

		1..5.times do
			rand_index = ((pool.length-1)*rand).to_i
			puts pool.length.to_s+' images, selected '+rand_index.to_s
			image = pool.slice(rand_index,1).first
			unless Image.find_by_path(image)
				i = Image.new({:path => image,:filename => image.split('/').last})
				i.save
			end
			if i = Image.find_by_path(image)
				small_pool << image if i.hits < 5
			end
		end
		small_pool << pool[((pool.length-1)*rand).to_i] if small_pool.length < 1
		@image = Image.find(:all,:conditions => ['path IN (?)',small_pool],:order => 'hits DESC',:limit => 1).first
		@image.thumb
		@site = site
		render "index"
	end

	def vote
		if i = Image.find(params[:id])
			i.points += params[:points].to_i if params[:points].to_i < 11
			i.save
		else
			# this should be unnecessary:
			# i = Image.new({:path => params[:path],:filename => params[:filename],:points => params[:points]})
		end
		puts params
		if params[:site] != ""
			path = '/sort/'+params[:site]+'/?o=x&last='+i.path
		else
			path = '/?o=x&last='+i.path
		end
		redirect_to path
>>>>>>> f53644d8b0d0854537349d15d0ec73128265c5ca
	end
	
	def place_site
		
		render "place"
	end

	def place_image

		render "place"
	end

end
