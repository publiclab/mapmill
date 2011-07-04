class Site < ActiveRecord::Base
	
	has_many :images
	validates_presence_of :name
	validates_uniqueness_of :name

	# reads sites directory to find all sites, whether they have records or not
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

	# creates records for any new sites in the Sites directory
	def self.import
		self.all.each do |site|
			# unless it already exists
			unless Site.find_by_name(site[0])
				s = Site.new({ :name => site[0] })
				s.save
			end
		end
	end

	# scans directory for images and imports them 
	# but does not generate thumbnails ... that might lead to thousands generating at once
	def import_images
		# collate all .jpgs from each chosen site folder
		d = Dir.new(RAILS_ROOT+'/public/sites/'+self.name)
		d.each do |image|
			if image[-3..-1] && image[-3..-1].downcase == 'jpg'
				unless Image.find_by_path(image)
					i = Image.new({:path => "sites/"+name+"/"+image,:filename => image.split('/').last,:site_id => self.id})
					i.save
				end
			end
		end
	end

	# returns _num_ images, starting with those with fewest votes
	def least_voted(num)
		Image.find(:all,:conditions => {:site_id => self.id},:order => "hits", :limit => num)
	end

	# returns _num_ images with fewer than _threshold_ votes, starting with those with fewest votes
	def voted_less_than(threshold,count)
		Image.find(:all,:conditions => ["site_id = ? AND hits < ?",self.id,threshold], :order => "hits", :limit => count)
	end

	# average score
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
		(10.00*points/votes).to_s.to(3)
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
