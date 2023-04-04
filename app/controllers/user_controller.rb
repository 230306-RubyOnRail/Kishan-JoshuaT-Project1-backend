require_relative '../../lib/json_web_token'
class UserController < ApplicationController
  include Authentication_Concern
  def create
    # need to add checks to see if all the null fields are filled
    @user = User.new(user_params)
    # @user.user_id = 1
    if @user.save
      render status: 200, json: {message: "User created successfully"}
    else
      render status: 400, json: {message: "Invalid"}
    end
  end

  def show
  end

  def login
    # require the username and the password

    @user = User.where(user_params)
    if @user.length == 1
      jwt = Jwt_Session.encode({user_id: @user[0].id, account_type: @user[0].account_type})
      render status: 200, json: {message: "User logged in successfully", token: jwt}
    else
      render status: 400, json: {message: "Invalid"}
    end
  end

  def index
    @user = User.all
    render json: @user
  end

  def delete
  end

  private
  def user_params
    params.require(:user).permit(:name, :username, :password, :account_type)
  end
end
