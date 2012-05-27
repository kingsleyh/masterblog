class Article < ActiveRecord::Base
  attr_accessible :title,:excerpt,:content,:tags,:user_id
  belongs_to :user


  validates :title, :presence => true
  validates :content, :presence => true

end
