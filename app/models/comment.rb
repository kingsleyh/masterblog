class Comment < ActiveRecord::Base
  attr_accessible :name, :email, :content, :article_id

  belongs_to :article

  validates :name, :presence => true
  validates :content, :presence => true
  validates :article_id, :presence => true

  def display_date
      created_at.strftime("%A %B #{created_at.day.ordinalize} %Y at %X")
  end

  def authenticate_captcha(key,answer)
    result = "0"
    begin
      result = Net::HTTP.get(URI.parse("http://captchator.com/captcha/check_answer/#{key}/#{answer}"))
    rescue => e
      puts "rescue: #{e}"
    end
    result == "1"
  end


end
