class DentistsController < ApplicationController
  #require current user to be admin
  before_action :authenticate, except: [:show]

  # require current user id to match id on request
  before_action :authorize, except: [:create]

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

  private

    def dentist_params
      params.required(:dentist).permit(:name, :office_name, :email, :phone, :address, :address_state, :address_zip, :address_city, :license_num)
    end
end
