class Image < ActiveRecord::Base
  belongs_to :site
  has_many :votes
  enum quality: [:good, :nok, :bad]

  def average_vote
    sum = 0
    self.votes.collect(&:value).each do |v|
      sum += v
    end
    if self.votes.length > 0
      sum / self.votes.length
    else
      0
    end
  end

  def vote_count
    Vote.where(image_id: self.id).count()
  end

  def self.ranked_by_vote
    Image.joins(:votes).group(Vote.arel_table[:image_id]).order(Vote.arel_table[:image_id].count :desc)
  end

end
