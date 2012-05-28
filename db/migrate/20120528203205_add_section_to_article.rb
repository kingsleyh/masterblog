class AddSectionToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :section_id, :integer
  end
end
