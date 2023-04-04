require_relative '../../lib/json_web_token'
require_relative './concerns/authentication_concern'
class UserController < ApplicationController
  include Authentication_Concern
  def create
    if params[:authorization][0][:account_type] == "manager"
      # need to add checks to see if all the null fields are filled
      @user = User.new(user_params)
      # @user.user_id = 1
      if @user.save
        render status: 200, json: {message: "User created successfully"}
      else
        render status: 400, json: {message: "Invalid"}
      end
    else
      render status: 400, json: {message: "You are not authorized"}
    end
  end

  def show
  end

  # def login
  #   # require the username and the password
  #
  #   @user = User.where(user_params)
  #   if @user.length == 1
  #     jwt = Jwt_Session.encode({user_id: @user[0].id, account_type: @user[0].account_type})
  #     render status: 200, json: {message: "User logged in successfully", token: jwt}
  #   else
  #     render status: 400, json: {message: "Invalid"}
  #   end
  # end

  def index
    if params[:authorization][0][:account_type] == "manager"
      @user = User.all
      render json: @user
    elsif params[:authorization][0][:account_type] == "employee"
      @user = User.where(id: params[:authorization][0][:user_id])
      render json: @user
    else
      render status: 400, json: {message: "You are not authorized"}
    end
  end

  def delete
  end

  private
  def user_params
    params.require(:user).permit(:name, :username, :password, :account_type)
  end
end
