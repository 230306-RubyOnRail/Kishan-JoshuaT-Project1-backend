class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :username, null: false
      t.string :password, null: false
      t.string :account_type , null: false

      t.timestamps
    end
    add_index :users, :username, unique: true
  end
end
