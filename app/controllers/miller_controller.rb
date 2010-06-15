class MillerController < ApplicationController

	def index
		pool = []
		Dir.new('public/sites').each do |site|
			if site[-6..-1] != '_thumb' && File.directory?('sites/'+site)
				d = Dir.new(RAILS_ROOT+'/public/sites/'+site)
				d.each do |image|
					if image[-3..-1] == 'jpg' && site+'/'+image != params[:last]
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

	def vote
		if i = Image.find_by_path(params[:path])
			i.points += params[:points].to_i if params[:points].to_i < 11
			i.save
		else
			# this should be unnecessary:
			# i = Image.new({:path => params[:path],:filename => params[:filename],:points => params[:points]})
		end
		redirect_to 'index?last='+i.path
	end

end
