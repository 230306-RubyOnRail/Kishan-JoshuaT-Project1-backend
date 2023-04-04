class User < ApplicationRecord
  has_many :reimbursement
  # def authenticated
  #   user = Token.where(token: @request[:headers]['Authorization'].split(' ').last).first # get the token from the request
  #   if user.nil? # if the token is invalid, return a 401 Unauthorized response
  #     return nil
  #   end
  #   account_type = User.where(id: user.user_id).first.account_type
  #   account_type.downcase!
  #   user = {id:user.user_id, account_type:account_type}
  # end
  def authenticate(pass)
    pass == password
  end
end
