class Snippet < ActiveRecord::Base
  attr_accessible :name, :content

  validates :name, :presence => true
  validates :content, :presence => true

  def self.get(snippet_name)
    Snippet.find_by_name(snippet_name).content
  end

end
