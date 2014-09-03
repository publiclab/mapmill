class Site < ActiveRecord::Base
  has_many :images
end


class Image < ActiveRecord::Base
  belongs_to :site
end
