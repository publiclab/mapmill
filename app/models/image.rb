class Image < ActiveRecord::Base
  belongs_to :site
  has_many :votes

  # in percent
  def average_vote
    sum = 0
    self.votes.collect(&:value).each do |v|
      sum += v
    end
    if self.votes.length > 0
      ((1.00*sum / self.votes.length)/0.02).round #deinteger, percentize
    else
      0
    end
  end

  def vote_count
    Vote.where(image_id: self.id).count()
  end

end
