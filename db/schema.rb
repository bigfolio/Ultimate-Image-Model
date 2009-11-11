# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091110044206) do

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", :force => true do |t|
    t.string   "local_attachment_file_name"
    t.string   "local_attachment_content_type"
    t.integer  "local_attachment_file_size"
    t.datetime "local_attachment_upated_at"
    t.string   "s3_attachment_file_name"
    t.string   "s3_attachment_content_type"
    t.integer  "s3_attachment_file_size"
    t.datetime "s3_attachment_upated_at"
    t.string   "title"
    t.string   "model"
    t.string   "exposure_time"
    t.string   "focal_length"
    t.string   "aperture"
    t.string   "width"
    t.string   "height"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
