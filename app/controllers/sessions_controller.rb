require 'jwt'
require_relative '../../lib/json_web_token'

class SessionsController < ApplicationController

  def create

    user = User.where(username: params["username"]).first # find the user by email
    if user&.authenticate(params["password"]) # check if the user exists and if the password entered is correct
      # if the user already has an active token, delete it
      if (tok = Token.where(user_id: user.id).first) # if the user already has a token, delete it
        puts "Deleting token #{tok.token}"
        tok.delete
      end
      random = SecureRandom.hex(32)
      token_value = JsonWebToken.encode({user_id: user.id, account_type: user.account_type, random: random})
      token = Token.create(token: token_value, user_id: user.id) # create a new token and save it to the database
      render status: 201, json: {message: "User logged in successfully", token: token.token, id: user.id, username: user.username, account_type: user.account_type}
    else
      render status: 401, json: {message: "Invalid email"}
    end
  end

  def destroy
    # Authorization: Bearer <token>
    # ["Authorization", "Bearer", "token"]
    token_header = @request[:headers]['Authorization'].split(' ').last
    token = Token.where(token: token_header).first
    render status: 401, json: { message: "Token is already deleted" } unless token
    token.delete if token
    render status: 200, json: {message: "User logged out successfully"}
    ##### should add a check to see if the token is already deleted
  end

  # def logged_in
  # end

end
