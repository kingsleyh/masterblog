class AddContentToSection < ActiveRecord::Migration
  def change
    add_column :sections, :content, :text
  end
end
