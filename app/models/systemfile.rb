class Systemfile < ActiveRecord::Base

  attr_accessible :filename, :filepath, :content

  validates :filename, :presence => true
  validates :filepath, :presence => true
  validates :content, :presence => true

  def is_image?
    find_mime(filename,'image')
  end

  def is_text_file?
    find_mime(filename,'text')
  end

  def is_css_file?
    find_mime(filename,'css')
  end

  def is_javascript_file?
    find_mime(filename,'javascript')
  end

  def is_ruby_file?
    find_mime(filename,'x-ruby')
  end

  #def content
  #  "woops"
  #  #File.read(upload.path(:original))
  #end
  #
  #def content=(new_content)
  #  #File.open(upload.path(:original), "w") { |f| f.puts new_content }
  #end

  private

  def find_mime(filename,mime)
    MIME::Types.type_for(filename).collect{|e| e.to_s.split("/")}.flatten.include?(mime) unless filename.nil?
  end

end