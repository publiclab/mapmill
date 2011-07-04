class Image < ActiveRecord::Base

	belongs_to :site

	def vote
		self.hits += 1
		self.save
	end

	def sitename
		self.path.split("/")[1]
	end

	def filename
		self.path.split("/").last
	end

	def thumb
		require 'mini_magick'
		thumb_path = 'public/thumbnails/'+self.site.name
		unless File.exists?(thumb_path+'/'+self.filename)
			image = MiniMagick::Image.from_file('public/sites/'+self.site.name+"/"+self.filename)
			image.resize "180X120"
			Dir.mkdir(thumb_path) unless File.exists?(thumb_path)
			thumbnail = File.open(thumb_path+'/'+filename,"wb+")
			image.write thumb_path+'/'+filename
			thumbnail.close
		end
		'/thumbnails/'+self.site.name+'/'+filename
	end

end
