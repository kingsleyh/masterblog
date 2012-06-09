class Section < ActiveRecord::Base
  attr_accessible :name, :content
  has_many :articles

  extend FriendlyId
  friendly_id :name, :use => :slugged

  validates :name, :presence => true
end
