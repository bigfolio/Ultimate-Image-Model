require 'mini_exiftool'
class Image < ActiveRecord::Base
  
  has_attached_file :local_attachment,
    :convert_options => { :all => '-auto-orient' },   
    :path => ":rails_root/public/uploads/images/:id_partition/:basename.:extension",
    :url => "/uploads/images/:id_partition/:basename.:extension"
  
  has_attached_file :s3_attachment,
    :styles => {
      :large => "900x600>",
      :medium => "600x400>",
      :square => "200x200#", 
      :small => "300x200>",
      :mini => "100x100#" },
    :convert_options => { :all => '-auto-orient' },   
    :storage => :s3,
    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
    :s3_permissions => 'public-read',
    :s3_protocol => 'https',
    :path => "images/:id_partition/:basename-:style.:extension"
  
  after_save :start_processing
  after_save :remove_local
  
  def url(style = nil)
    # Use this method to output your image's URL
    # It will show the URL based on the available attachment (preference is S3)
    s3_attachment.file? ? s3_attachment.url(style) : local_attachment.url
  end
  
  def start_processing
    # We're using the timestamp fields to determine if we should process
    # Basically only process the image if it's a new record (i.e. created and updated are the same)
    if created_at == updated_at
      self.send_later(:get_exif)
      self.send_later(:move_to_s3)
    end
  end
  
  def move_to_s3
    self.s3_attachment = File.new(self.local_attachment.path)
    self.save
  end
  
  def remove_local
    if s3_attachment.file? && s3_attachment_file_size == local_attachment_file_size
      local_attachment.destroy
      self.save # Paperclip's destroy method is supposed to auto-save but it doesn't seem to
    end
  end
  
  def get_exif
    photo = MiniExiftool.new(local_attachment.path)
    self.update_attributes(:title => photo.Title,
                           :model => photo.Model,
                           :exposure_time => photo.ExposureTime,
                           :focal_length => photo.FocalLength,
                           :aperture => photo.ApertureValue,
                           :width => photo.ExifImageWidth,
                           :height => photo.ExifImageHeight,
                           :description => photo.Description)
  end
end