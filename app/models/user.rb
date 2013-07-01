class User < ActiveRecord::Base
  devise :cas_authenticatable, :trackable

  attr_accessible :username

  validates :username, :presence => true
end
