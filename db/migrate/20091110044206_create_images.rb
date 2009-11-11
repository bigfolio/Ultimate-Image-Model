class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|

      t.string   :local_attachment_file_name
      t.string   :local_attachment_content_type
      t.integer  :local_attachment_file_size
      t.datetime :local_attachment_upated_at
      
      t.string   :s3_attachment_file_name
      t.string   :s3_attachment_content_type
      t.integer  :s3_attachment_file_size
      t.datetime :s3_attachment_upated_at
      
      t.string    :title
      t.string    :model
      t.string    :exposure_time
      t.string    :focal_length
      t.string    :aperture
      t.string    :width
      t.string    :height
      
      t.text      :description
      
      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
