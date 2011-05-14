class Site
	def self.all
		sitepaths = []
		dirs = Dir.new('public/sites')
		dirs.each do |dir|
			sitepaths << dir if dir[-6..-1] != '_thumb' && dir[0..0] != '.' 
		end
		sites = []
		sitepaths.each do |site|
			d = Dir.new(RAILS_ROOT+'/public/sites/'+site)	
			images = []
			d.each do |file|
				images << file if file[-3..-1] && file[-3..-1].downcase == 'jpg'
			end
			sites << [site,images.length]
		end
		sites
	end

	def self.get(site)
		dir = Dir.new(RAILS_ROOT+'/public/sites/'+site)
		dir.first
	end
end
