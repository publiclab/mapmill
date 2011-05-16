class Site < ActiveRecord::Base
	
	has_many :images
	validates_presence_of :name

	def self.all
		sitepaths = []
		dirs = Dir.new('public/sites')
		dirs.each do |dir|
			sitepaths << dir if dir[-6..-1] != '_thumb' && dir[0..0] != '.' 
		end
		sites = []
		sitepaths.each do |sitename|
			images = self.imagenames_from_dir(sitename)
			sites << [sitename,images.length]
		end
		sites
	end

	def average
		count = self.images.length
		points = 0
		votes = 0
		self.images.each do |image|
			if image.hits > 0
				puts image.points.to_s + ' of ' + image.hits.to_s
				votes += image.hits
				points += image.points
			end
		end
		points/votes
	end

	def image_count
		Dir.glob(RAILS_ROOT+self.path+'/*.jpg').length	
	end
	
	def path
		'/public/sites/'+self.name
	end

	def self.imagenames_from_dir(dirname)
		Dir.glob(RAILS_ROOT+'/public/sites/'+dirname+'/*.jpg')
	end

	def self.get(site)
		dir = Dir.new(RAILS_ROOT+'/public/sites/'+site)
		dir.first
	end

end
