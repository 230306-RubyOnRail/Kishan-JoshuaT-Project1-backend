require 'jwt'
require_relative '../../../lib/json_web_token'
module Authentication_Concern
  extend ActiveSupport::Concern

  included do
    before_action :add_auth_header_to_params
  end
  def add_auth_header_to_params
    auth_header = request.headers["Authorization"].split(" ")
    jwt = JsonWebToken.decode(auth_header[1]) if auth_header[0] == "Bearer"
    params[:authorization] = jwt
  end
end