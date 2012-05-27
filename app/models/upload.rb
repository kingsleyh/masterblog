class Upload < ActiveRecord::Base
  attr_accessible :upload

  has_attached_file :upload, :styles => { :medium => "300x300>", :thumb => "100x100>", :large => "500x500>"}
  validates_attachment :upload, :presence => true,
    :content_type => { :content_type => ['image/jpeg', 'image/jpg', 'image/png'] },
    :size => { :in => 0..500.kilobytes }

  def file_name
    upload.url(:medium).split("/")[-1].split("?")[0]
  end

end
