class PaypalController < ApplicationController
  # client: ENV['paypal_sandbox_client']
  # production: ENV['paypal_live_client']

  def create
    @order = Order.find(params[:order_id])
    @items = []

    @order.order_items.each do |item|
      @items.push({
        :quantity => item.quantity,
        :name => item.unit_name,
        :price => item.unit_price
      })
    end
    
    @payment = HTTParty.post(
      "https://api.sandbox.paypal.com/v1/payments/payment", {
        :headers => { 'Content-Type' => 'application/json' },
        :body => {
          :intent => 'sale',
          :payer => {
            :payment_method => "paypal"
          },
          :redirect_urls =>  {
            :return_url => "http://properguideimplant.com",
            :cancel_url => "http://properguideimplant.com"
          },
          :transactions => {
            :amount => {
              :total => @order[:total],
              :currency => "USD",
              :details =>  {
                :subtotal => @order[:subtotal],
                :shipping => @order[:shipping],
                :tax => @order[:tax],
              }
            },
            :item_list => {
              :items => @items
            }
          }
        }.to_json
      })

    render json: {payment: @payment}
  end

  def execute

  end
end
