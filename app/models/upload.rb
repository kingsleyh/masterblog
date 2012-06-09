class Upload < ActiveRecord::Base
  attr_accessible :upload, :content

  IMAGE_CONTENT_TYPE = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif', 'image/tiff']

  has_attached_file :upload, :styles => { :medium => "300x300>", :thumb => "100x100>", :large => "500x500>"},
   :path => ":rails_root/public/system/:attachment/:style_:basename.:extension" ,
   :url => "/system/:attachment/:style_:basename.:extension"
  validates_attachment :upload, :presence => true
    #:content_type => { :content_type => IMAGE_CONTENT_TYPE },
    #:size => { :in => 0..500.kilobytes }

  before_post_process :conditionally_resize


  def conditionally_resize
    is_image?
  end

  def file_name
    upload.url(:original).split("/")[-1].split("?")[0]
  end

  def is_image?
    IMAGE_CONTENT_TYPE.include?(upload_content_type)
  end

  def is_text_file?
   mimes = upload_content_type.split("/")
   mimes.include?('text') or mimes.include?('javascript')
  end

  def is_css_file?
    upload_content_type.split("/").include?('css')
  end

  def content
    File.read(upload.path(:original))
  end

  def content=(new_content)
    File.open(upload.path(:original),"w"){|f| f.puts new_content}
  end


end
