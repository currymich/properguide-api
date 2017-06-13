class DentistsController < ApplicationController
  #require current user to be admin
  before_action :authenticate, except: [:show, :index]

  # require current user id to match id on request
  before_action :authorize, except: [:create, :index]

  def create
    @dentist = Dentist.new(dentist_params)

    if @dentist.save!
      @user = User.new(name: params[:dentist][:name], username: params[:dentist][:email], email: params[:dentist][:email], password: "temp_pass", dentist_id: @dentist.id)

      if @user.save!
        @user.authenticate(params[:dentist][:password])
        @token = token(@user.id, @user.email)

        render json: {message: "user created and logged in", status: 201, dentist: @dentist, user: @user, token: @token}
      end
    else
      render json: {status: 422}
    end
  end

  def show
    # return dentist info
    @dentist = Dentist.find(params[:id])

    render json: {dentist: @dentist}
  rescue ActiveRecord::RecordNotFound => error
    render json: {error: "Dentist not found"}
  end

  def index
    if current_user.admin?
      render json: {dentists: Dentist.all}
    else
      @dentist = Dentist.find(current_user.dentist_id)

      render json: {dentists: @dentist}
    end

    rescue ActiveRecord::RecordNotFound => error
      render json: {error: "Dentist not found"}
  end

  def update
    @dentist = Dentist.find(params[:id])

    if @dentist.update(dentist_params)
      render json:{status: 200, message: "Dentist updated", dentist: @dentist}
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

    def dentist_params
      params.required(:dentist).permit(:name, :office_name, :email, :phone, :address, :address_state, :address_zip, :address_city, :license_num)
    end
end
