class Article < ActiveRecord::Base
  attr_accessible :title, :excerpt, :content, :tags, :user_id, :section_id
  belongs_to :user
  belongs_to :section
  has_many :comments

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
    Article.all.collect { |a| list << a if a.tags.split(",").collect { |t| t.strip }.include?(tag.strip) }
    list
  end

  def self.all_tags
    Article.all.collect { |a| a.tags.split(",").collect { |t| t.strip }.flatten }.flatten.uniq
  end

  def self.by_archive
    archive = ActiveSupport::OrderedHash.new
    Article.all.each do |article|
      month_year = article.created_at.strftime("%B %Y")
      archive[month_year] ||= []
      archive[month_year] << article
    end
    archive
  end

  def self.search_for(criteria)
    Article.where("title like ? or excerpt like ? or content like ?","%#{criteria}%","%#{criteria}%","%#{criteria}%")
  end

  def self.by_archive_date(month_year)
    result = []
    result = Article.where("id in (#{by_archive[month_year].collect { |i| i.id }.join(',') })") unless by_archive[month_year].nil?
    result
  end

  def display_date
    created_at.strftime("%A %B #{created_at.day.ordinalize} %Y")
  end

  def display_content
    Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :fenced_code_blocks => true, :tables => true).render(content)
  end

  def display_excerpt
    Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :fenced_code_blocks => true, :tables => true).render(excerpt)
  end
end
