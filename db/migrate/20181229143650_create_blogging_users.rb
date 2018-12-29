class CreateBloggingUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :blogging_users, id: :uuid do |t|
      t.string :name

      t.timestamps null: true
    end
  end
end
