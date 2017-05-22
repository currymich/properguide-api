class ApplicationController < ActionController::API
  def authenticate
    render json: {status: 401, message: "unauthorized"} unless decode_token(bearer_token)
  end

  def authorize
    render json: {status: 401, message: "unauthorized"} unless current_user && current_user.id == params[:id].to_i
  end

  def authorize_cart
    render json: {status: 401, message: "unauthorized"} unless current_user.id == current_order.user.id
  end

  def bearer_token
    pattern = /^Bearer /
    header  = request.env["HTTP_AUTHORIZATION"] # <= env
    header.gsub(pattern, '') if header && header.match(pattern)
  end

  def current_user
    return if !bearer_token

    decoded_jwt = decode_token(bearer_token)

    @current_user ||= User.find(decoded_jwt["user"]["id"])
  end

  def current_order
    return if current_user.nil?

    @user = current_user

    if !@user.orders.find_by(order_status_id: 1).nil?
      @user.orders.find_by(order_status_id: 1)
    else
      @user.orders.create(order_status_id: 1)
    end

  end

  def decode_token(token)
    @token ||= JWT.decode(token, nil, false)[0] # this will error if the token is invalid or expired
  rescue
    render json: {status: 401, message: 'invalid or expired token'}
  end
end
