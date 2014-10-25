class Vote < ActiveRecord::Base
  belongs_to :image

  def self.find_by_image(image_id)
    votes = Vote.find_by image: image_id 
    return votes 
  end
end
