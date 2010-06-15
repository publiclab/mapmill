class Image < ActiveRecord::Base

	after_save :hit_increment

	def hit_increment

		self.hits += 1

	end

	def thumb
		name = self.path[0..-3]+'_thumb.jpg'
		unless File.exists?(name)
			image = MiniMagick::Image.from_file(self.path)
			# We'll resize the image to 200x140 pixels.
			image.resize "180X120"
			# We'll create a *temporary* thumbnail in a folder named 'thumbnails' within the 'tmp' folder in the application's root.
			thumbnail = File.open(name,"wb+")
			image.write name
			# Close the temporary thumbnail, then delete it
			thumbnail.close
		end
	end

end
