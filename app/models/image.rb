class Image < ActiveRecord::Base

	before_save :hit_increment

	def hit_increment
		self.hits += 1
	end

	def site
		self.path.split("/")[1]
	end

	def filename
		self.path.split("/").last
	end

	def thumb
		require 'mini_magick'
		path_parts = self.path.split('/')
		thumb_path = 'public/'+path_parts[0..path_parts.length-2].join('/')+'_thumb/'
		filename = path_parts.last
		unless File.exists?(thumb_path+'/'+filename)
			image = MiniMagick::Image.from_file('public/'+self.path)
			# We'll resize the image to 200x140 pixels.
			image.resize "180X120"
			# We'll create a *temporary* thumbnail in a folder named 'thumbnails' within the 'tmp' folder in the application's root.
			Dir.mkdir(thumb_path) unless File.exists?(thumb_path)
			thumbnail = File.open(thumb_path+filename,"wb+")
			image.write thumb_path+'/'+filename
			# Close the temporary thumbnail, then delete it
			thumbnail.close
		end
		path_parts[0..path_parts.length-2].join('/')+'_thumb/'+filename
	end

end
