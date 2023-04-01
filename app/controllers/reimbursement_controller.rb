require_relative '../../lib/jwt_session'
class ReimbursementController < ApplicationController
  before_action :add_auth_header_to_params
  # before_action :authorization
  def create
    # need to add checks to see if all the null fields are filled

    # makes new reimbursement
    @reimbursement = Reimbursement.new(reimburse_params)
    # checks if the user_id in the reimbursement is the same as the user_id in the token
    puts params[:authorization]
    if !(@reimbursement.user_id = params[:authorization]["user_id"])
      render status: 400, json: {message: "Invalid"}

      # if the reimbursement is valid, save it and return a success message
    elsif @reimbursement.save
      render status: 200, json: {message: "Reimbursement request made successfully"}
      # if the reimbursement is not valid, return an error message
    else
      render status: 400, json: {message: "Invalid"}
    end

  end

  def index
    @reimbursement = Reimbursement.all
    render json: @reimbursement
  end

  def show
  end

  def delete
  end

  def update
  end


  # returns the reimbursement params that are allowed to be passed in
  private
  def reimburse_params
    params.require(:reimbursement).permit(:description, :amount, :status, :user_id)
  end

  # adds the authorization header to the params
  # this is used to get the user_id from the token
  # this is used to check if the user_id in the reimbursement is the same as the user_id in the token
  def add_auth_header_to_params
    auth_header = request.headers["Authorization"].split(" ")
    jwt = Jwt_Session.decode(auth_header[1])[0] if auth_header[0].present?
    params[:authorization] = jwt
  end

  # def authorization
  #   token = request.env["HTTP_AUTHORIZATION"].split(" ")
  #   token = token[1]
  #   jwt = Jwt_Session.decode(token)[0]
  # end
end
