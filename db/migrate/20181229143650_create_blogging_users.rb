class CreateBloggingUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :blogging_users do |t|
      t.string :name

      t.timestamp
    end
  end
end
