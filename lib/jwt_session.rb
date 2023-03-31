# The secret must be a string
require 'jwt'
class Jwt_Session
  @hmac_secret = 'my$ecretK3y'
  def self.encode(payload)
    token = JWT.encode payload, @hmac_secret, 'HS256'
  end

  def self.decode(token)
    decoded_token = JWT.decode token, @hmac_secret, true, { algorithm: 'HS256' }
  end

end

# user = {user_id: 1, account_type: "employee"}
#
# test_token = Jwt_Session.encode(user)
# puts test_token
# test2 = Jwt_Session.decode(test_token)
# puts test2[0]["user_id"]


