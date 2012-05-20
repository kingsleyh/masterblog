class Article < ActiveRecord::Base
  attr_accessible :title,:excerpt,:content,:tags,:user_id
  belongs_to :user
end
