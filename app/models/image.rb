class Image < ActiveRecord::Base
  belongs_to :site
  has_many :votes
  enum quality: [:good, :nok, :bad]

  def vote_count
    Vote.where(image_id: self.id).count()
  end

  def self.ranked_by_vote
    Image.joins(:votes).group(Vote.arel_table[:image_id]).order(Vote.arel_table[:image_id].count)
  end

end
