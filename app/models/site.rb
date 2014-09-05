class Site < ActiveRecord::Base
  validates :name, uniqueness: true, :presence => true,
                    :length => { :minimum => 5 }
  validates :date, :presence => true

  has_many :images
end


class Image < ActiveRecord::Base
  belongs_to :site
end
