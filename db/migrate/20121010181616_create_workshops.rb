class CreateWorkshops < ActiveRecord::Migration
  def change
    create_table "workshops", :force => true do |t|
      t.string   "name"
      t.text     "ingress"
      t.text     "body"
      t.integer  "number"
      t.integer  "user_id"
      t.boolean  "published"
      t.boolean  "got_comments"
      t.datetime "created_at",                  :null => false
      t.datetime "updated_at",                  :null => false
      t.string   "workshop_image_file_name"
      t.string   "workshop_image_content_type"
      t.integer  "workshop_image_file_size"
      t.datetime "workshop_image_updated_at"
    end
  end
end
