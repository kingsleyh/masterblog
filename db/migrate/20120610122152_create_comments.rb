class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :name
      t.string :email
      t.text :content
      t.integer :article_id
      t.timestamps
    end
  end
end
