class Image < ActiveRecord::Base

	belongs_to :site

	def vote(key)
		if key && self.site.unique_participant(key)
			p = Participant.new({:key => key,:site_id => self.site_id}) 
			p.save
		end
		self.hits += 1
		self.save
	end

	def sitename
		self.path.split("/")[1]
	end

	def filename
		self.path.split("/").last
	end

	def fullsize_thumb
		require 'mini_magick'
		thumb_path = 'public/fullsize_thumbnails/'+self.site.name
    		Dir.mkdir('public/fullsize_thumbnails') unless File.exists?('public/fullsize_thumbnails')
		unless File.exists?(thumb_path+'/'+self.filename)
			image = MiniMagick::Image.from_file('public/sites/'+self.site.name+"/"+self.filename)
			image.crop "180x135+1500+1000"#+(image.width/2-90)+"+"+(image.height/2-60)
			Dir.mkdir(thumb_path) unless File.exists?(thumb_path)
			thumbnail = File.open(thumb_path+'/'+filename,"wb+")
			image.write thumb_path+'/'+filename
			thumbnail.close
		end
		'/fullsize_thumbnails/'+self.site.name+'/'+filename
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
