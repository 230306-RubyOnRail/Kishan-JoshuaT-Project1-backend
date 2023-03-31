class CreateReimbursements < ActiveRecord::Migration[7.0]
  def change
    create_table :reimbursements do |t|
      t.string :description, null: false
      t.string :amount, null: false
      t.string :status, default_insert_value: "pending"

      t.timestamps
    end
  end
end
