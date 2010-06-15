class MillerController < ApplicationController

	def index
		pool = []
		f = File.new('public/sites.txt')
		sites = f.read.split("\n")
		sites.each do |site|
			d = Dir.new(RAILS_ROOT+'/public/'+site)
			d.each do |image|
				if image[-3..-1] == 'jpg'
					pool << site+'/'+image
				end
			end
		end
		small_pool = []

		1..5.times do
			rand_index = ((pool.length-1)*rand).to_i
			image = pool.slice(rand_index,1).first
			small_pool << image
			unless Image.find_by_path(image)
				i = Image.new({:path => image,:filename => image.split('/').last})
				i.save
			end
		end
		@image = Image.find(:all,:conditions => ['path IN (?)',small_pool],:order => 'hits DESC',:limit => 1).first
	end

	def vote
		if i = Image.find_by_path(params[:path])
			i.points += params[:points].to_i if params[:points].to_i < 11
			i.save
		else
			# this should be unnecessary:
			# i = Image.new({:path => params[:path],:filename => params[:filename],:points => params[:points]})
		end
		redirect_to 'index'
	end

end
