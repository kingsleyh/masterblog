class Article < ActiveRecord::Base
  attr_accessible :title,:excerpt,:content,:tags,:user_id, :section_id
  belongs_to :user
  belongs_to :section

  extend FriendlyId
  friendly_id :title, :use => :slugged

  validates :title, :presence => true
  validates :content, :presence => true
  validates :section, :presence => true

  def author
    user.name
  end

  def self.find_by_tag(tag)
    list = []
    Article.all.collect{|a| list << a if a.tags.split(",").collect{|t| t.strip}.include?(tag.strip)}
    list
  end

  def display_date
    created_at.strftime("%A %B #{created_at.day.ordinalize} %Y")
  end

  def display_content
   Redcarpet::Markdown.new(Redcarpet::Render::HTML,:autolink => true, :fenced_code_blocks => true, :tables => true).render(content)
  end

  def display_excerpt
    Redcarpet::Markdown.new(Redcarpet::Render::HTML,:autolink => true, :fenced_code_blocks => true, :tables => true).render(excerpt)
  end
end
