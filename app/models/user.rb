class User < ActiveRecord::Base
  attr_accessible :email, :name

  extend FriendlyId
  friendly_id :name, :use => :slugged

  has_many :services, :dependent => :delete_all
  has_many :articles, :dependent => :delete_all
end
