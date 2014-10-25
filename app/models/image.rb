class Image < ActiveRecord::Base
  belongs_to :site
  has_many :votes
  enum quality: [:good, :nok, :bad]
end
