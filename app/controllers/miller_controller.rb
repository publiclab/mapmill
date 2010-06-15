class MillerController < ApplicationController

	def index
		pool = []
		f = File.new('public/sites.txt')
		sites = f.read.split("\n")
		sites.each do |site|
			d = Dir.new(RAILS_ROOT+'/public/'+site)
			d.each do |image|
				if image[-3..-1] == 'jpg' && site+'/'+image != params[:last]
					pool << site+'/'+image
				end
			end
		end
		small_pool = []

		1..5.times do
			rand_index = ((pool.length-1)*rand).to_i
			puts pool.length.to_s+' images, selected '+rand_index.to_s
			image = pool.slice(rand_index,1).first
			small_pool << image if Image.find_by_path(image).hits > 5
			unless Image.find_by_path(image)
				i = Image.new({:path => image,:filename => image.split('/').last})
				i.save
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
