class Token < ApplicationRecord
  belongs_to :user
  def authenticate_token(t)
    t == token
  end
end
