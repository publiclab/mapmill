class Image < ActiveRecord::Base
  belongs_to :site
  enum quality: [:good, :ok, :unuseful]

  has_attached_file :uploaded_file, styles: { original: "4000x4000>", large: "1500x1500>", medium: "300x300>", small: "200x200>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"

end
