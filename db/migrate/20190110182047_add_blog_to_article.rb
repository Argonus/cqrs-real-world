class AddBlogToArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :blogging_articles, :blog_id, :uuid
  end
end
