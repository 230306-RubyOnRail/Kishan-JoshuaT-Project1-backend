require_relative '../../lib/jwt_session'
class ReimbursementController < ApplicationController
  def create
    # need to add checks to see if all the null fields are filled
    #@user = User.new()

    #puts "PARAM #{params.class}"
    puts "PARAM #{params}"
    puts "AUTHORIZATION #{authorization}"
    puts "CLASS #{authorization["user_id"].class}"
    puts "AUTHORIZATION[USER_ID] #{authorization["user_id"]}"



    params[:user_id] = authorization["user_id"]
    puts "PARAM #{params}"
    puts "class #{reimburse_params.class}"
    puts "Rimburse_params #{reimburse_params}"

    test2 = reimburse_params
    @reimbursement = Reimbursement.new(reimburse_params)
    puts "REIMBURSEMENT #{@reimbursement}"
    if authorization["user_id"].nil?
      render status: 400, json: {message: "User not valid"}
    elsif @reimbursement.save
      render status: 200, json: {message: "Reimbursement request made successfully"}
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

  private
  def reimburse_params
    params.require(:reimbursement).permit(:description, :amount, :status)
  end

  def authorization
    token = request.env["HTTP_AUTHORIZATION"].split(" ")
    token = token[1]
    jwt = Jwt_Session.decode(token)[0]
  end
end
