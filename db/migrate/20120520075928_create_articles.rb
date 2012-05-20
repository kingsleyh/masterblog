class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string  :title
      t.text    :excerpt
      t.text    :content
      t.integer :user_id
      t.string  :tags
      t.timestamps
    end
  end
end
