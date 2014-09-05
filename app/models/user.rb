class User < ActiveRecord::Base
  validates :email, uniqueness: true, :presence => true,
                    :length => { :minimum => 5 }

  def self.find_by_identity_url (id_url)
    u = User.find_by identity_url: id_url
    return u
  end
end
