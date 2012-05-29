class Snippet < ActiveRecord::Base
  attr_accessible :name, :content

  def self.get(snippet_name)
    Snippet.find_by_name(snippet_name).content
  end

end
