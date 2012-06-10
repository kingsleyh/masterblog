class Comment < ActiveRecord::Base
  attr_accessible :name, :email, :content, :article_id

  belongs_to :article

  validates :name, :presence => true
  validates :content, :presence => true
  validates :article_id, :presence => true

  def display_date
      created_at.strftime("%A %B #{created_at.day.ordinalize} %Y at %X")
  end

end
