class CreateBloggingArtciles < ActiveRecord::Migration[5.2]
  def change
    create_table :blogging_articles, id: :uuid do |t|
      t.string :title
      t.text :content
      t.uuid :user_id

      t.timestamps null: true, index: true
    end
  end
end
