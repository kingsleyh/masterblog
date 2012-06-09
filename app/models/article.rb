class Article < ActiveRecord::Base
  attr_accessible :title,:excerpt,:content,:tags,:user_id, :section_id
  belongs_to :user
  belongs_to :section

  extend FriendlyId
  friendly_id :title, :use => :slugged

  validates :title, :presence => true
  validates :content, :presence => true
  validates :section, :presence => true

end
