class Site < ActiveRecord::Base
  validates :name, uniqueness: true, :presence => true,
                    :length => { :minimum => 5 }
  validates :date, :presence => true

  has_many :images
end


