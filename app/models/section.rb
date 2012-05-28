class Section < ActiveRecord::Base
  attr_accessible :name, :content
  has_many :articles

  validates :name, :presence => true
end
