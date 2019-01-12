class CreateAccountUser < ActiveRecord::Migration[5.2]
  def change
    create_table :account_users, id: :uuid do |t|
      t.string :first_name
      t.string :last_name
      t.datetime :confirmed_at

      t.timestamps null: false
    end
  end
end
