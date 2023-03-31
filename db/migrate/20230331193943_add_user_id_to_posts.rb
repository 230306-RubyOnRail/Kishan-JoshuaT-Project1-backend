class AddUserIdToPosts < ActiveRecord::Migration[7.0]
  def change
    add_reference :reimbursements, :user, null: false, foreign_key: true
  end
end
