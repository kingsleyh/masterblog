class User < ActiveRecord::Base
  attr_accessible :email, :name
  has_many :services
  has_many :articles
end
