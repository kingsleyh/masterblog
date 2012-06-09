class User < ActiveRecord::Base
  attr_accessible :email, :name

  extend FriendlyId
  friendly_id :name, :use => :slugged

  has_many :services
  has_many :articles
end
