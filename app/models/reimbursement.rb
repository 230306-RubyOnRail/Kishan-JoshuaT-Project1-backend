# Purpose: Model for reimbursement table
# has one user assigned to it
class Reimbursement < ApplicationRecord
  has_one :user, foreign_key: true
end
