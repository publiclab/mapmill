class Vote < ActiveRecord::Base
  belongs_to :image

  def self.find_by_image(image)
    votes = Vote.where(image: image)
    return votes 
  end
end
