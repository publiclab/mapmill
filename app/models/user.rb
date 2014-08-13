class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :openid_authenticatable

  def self.build_from_identity_url(identity_url)
    User.new(:identity_url => identity_url)
  end
end
