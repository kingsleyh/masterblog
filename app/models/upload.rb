class Upload < ActiveRecord::Base
  attr_accessible :upload

  IMAGE_CONTENT_TYPE = ['image/jpeg', 'image/jpg', 'image/png']

  has_attached_file :upload, :styles => { :medium => "300x300>", :thumb => "100x100>", :large => "500x500>"}
  validates_attachment :upload, :presence => true
    #:content_type => { :content_type => IMAGE_CONTENT_TYPE },
    #:size => { :in => 0..500.kilobytes }

  before_post_process :conditionally_resize


  def conditionally_resize
    is_image?
  end

  def file_name
    upload.url(:medium).split("/")[-1].split("?")[0]
  end

  def is_image?
    IMAGE_CONTENT_TYPE.include?(upload_content_type)
  end

end
