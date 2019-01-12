class AddConfirmedToBloggingUser < ActiveRecord::Migration[5.2]
  def change
    add_column :blogging_users, :confirmed, :boolean
  end
end
