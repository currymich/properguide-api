class UsersController < ApplicationController

  def login

    @user = User.find_by(email: params[:user][:email])

    if @user && @user.authenticate(params[:user][:password])
      @token = token(@user.id, @user.email)

      render json: {status: 201, user: @user, message: "user logged in", token: @token}
    else
      render json: {status: 401, message: "unauthorized"}
    end
  end

  def update
    @user = User.find(params[:id])

    render json: {status: 401, message: "unauthorized"} unless current_user && (current_user.id == @user.id || current_user.admin?)

    if @user.update!(user_params)
      render json:{status: 200, message: "User updated", user: @user}
    else
      render json:{status: 422, message: "Couldn't process updated params"}
    end
  end

  private

    def token(id, email)
      JWT.encode(payload(id, email), ENV['jwt_salt'], 'HS256')
    end

    def payload(id, email)
      {
        exp: (Time.now + 1.day).to_i,
        iat: Time.now.to_i,
        user: {
          id: id,
          email: email
        }
      }
    end

    def user_params
      params.required(:user).permit(:email, :password, :name)
    end
end
