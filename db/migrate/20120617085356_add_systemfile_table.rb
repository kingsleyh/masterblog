class AddSystemfileTable < ActiveRecord::Migration
  def change
    create_table :systemfiles do |t|
      t.string :filename
      t.string :filepath
      t.text :content
    end
  end
end
