class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.has_attached_file :upload
      t.timestamps
    end
  end
end
