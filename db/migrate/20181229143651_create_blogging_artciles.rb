class CreateBloggingArtciles < ActiveRecord::Migration[5.2]
  def change
    create_table :blogging_articles do |t|
      t.string :title
      t.text :content
      t.references :blogging_users, index: true, foreign_key: true

      t.timestamp
    end
  end
end
