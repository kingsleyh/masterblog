class Snippet < ActiveRecord::Base
  attr_accessible :name, :content

  validates :name, :presence => true
  validates :content, :presence => true

  def self.get(snippet_name)
    ERB.new(Snippet.find_by_name(snippet_name).content).result(binding)
  end

end
