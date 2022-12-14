class Api::V1::UsersController < ApplicationController

  def create
    # binding.pry
   user = User.new(user_params)
   if user.save
     render json: UserSerializer.new(user), status: 201
   elsif User.exists?(email: user_params[:email].downcase)
     render :json => {:error => "email taken"}.to_json, :status => 400
   elsif user_params[:password] != user_params[:password_confirmation]
     render :json => {:error => "password and confirmation mismatch"}.to_json, :status => 400
   else EmailValidator.valid?(user_params[:email]) == false
     render :json => {:error => "bad email"}.to_json, :status => 400
   end
 end

     private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
