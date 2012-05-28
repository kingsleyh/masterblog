class Article < ActiveRecord::Base
  attr_accessible :title,:excerpt,:content,:tags,:user_id, :section_id
  belongs_to :user
  belongs_to :section


  validates :title, :presence => true
  validates :content, :presence => true
  validates :section, :presence => true

end
