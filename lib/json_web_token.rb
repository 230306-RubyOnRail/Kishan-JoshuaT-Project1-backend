# The secret must be a string
require 'jwt'
class JsonWebToken
  @hmac_secret = Rails.application.credentials.dig(:secret_key_base)
  def self.encode(payload)
    token = JWT.encode payload, @hmac_secret, 'HS256'
  end

  def self.decode(token)
    # decoded_token = JWT.decode(token, @hmac_secret, true, { algorithm: 'HS256' })[0]
    JWT.decode(token, @hmac_secret, true, {algorithm: 'HS256'})
  rescue JWT::ExpiredSignature, JWT::VerificationError => e
    raise ExceptionHandler::ExpiredSignature, e.message
  rescue JWT::DecodeError, JWT::VerificationError => e
    raise ExceptionHandler::DecodeError, e.message
  end
end

# user = {user_id: 1, account_type: "employee"}
#
# test_token = Jwt_Session.encode(user)
# puts test_token
# test2 = Jwt_Session.decode(test_token)
# puts test2[0]["user_id"]


