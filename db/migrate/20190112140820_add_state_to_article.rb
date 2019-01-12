class AddStateToArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :blogging_articles, :state, :integer, default: 0
  end
end
