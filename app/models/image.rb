class Image < ActiveRecord::Base
  belongs_to :site
  enum quality [:good, :ok, :unuseful]
end
