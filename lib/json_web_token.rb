# The secret must be a string
require 'jwt'
class JsonWebToken
  @hmac_secret = "a9fbb79039302bf16199a407e7a51dfbcfffb6c6f6bfee0cf00bdbc21cee4fa870084ab1691d0baa33f550fb1b85b50b649ade8bc27bdc0fb1b78e61dd137015"
  def self.encode(payload)
    token = JWT.encode payload, @hmac_secret, 'HS256'
  end

  def self.decode(token)
    # decoded_token = JWT.decode(token, @hmac_secret, true, { algorithm: 'HS256' })[0]
    JWT.decode(token, @hmac_secret, true, {algorithm: 'HS256'})
  rescue JWT::ExpiredSignature, JWT::VerificationError => e
    raise JWT::ExpiredSignature, e.message
  rescue JWT::DecodeError, JWT::VerificationError => e
    raise JWT::DecodeError, e.message
  end
end

# user = {user_id: 1, account_type: "employee"}
#
# test_token = Jwt_Session.encode(user)
# puts test_token
# test2 = Jwt_Session.decode(test_token)
# puts test2[0]["user_id"]


