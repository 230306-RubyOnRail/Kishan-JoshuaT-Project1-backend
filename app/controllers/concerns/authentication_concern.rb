# frozen_string_literal: true
require_relative '../../../lib/json_web_token'
module Authentication_Concern
  extend ActiveSupport::Concern

  included do
    before_action :add_auth_header_to_params
  end
  def add_auth_header_to_params
    if not request.headers['Authorization'].present?
      render status: 400, json: {message: 'No token provided'}
      return
    elsif request.headers['Authorization'].split(' ').length != 2
      render status: 400, json: {message: 'Invalid token for authorization'}
      return
    end

    auth_header = request.headers['Authorization'].split(' ')
    jwt = JsonWebToken.decode(auth_header[1]) if auth_header[0] == 'Bearer'
    params[:authorization] = jwt
    end
end