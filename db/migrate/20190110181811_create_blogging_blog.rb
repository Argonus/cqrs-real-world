class CreateBloggingBlog < ActiveRecord::Migration[5.2]
  def change
    create_table :blogging_blogs do |t|
      t.string :name
      t.string :published
      t.uuid :user_id

      t.timestamps null: false
    end
  end
end
