class PaypalController < ApplicationController
  # client: ENV['paypal_sandbox_client']
  # production: ENV['paypal_live_client']

  def create
    @order = Order.find(params[:order_id])
    @payment = HTTParty.post(
      "https://api.sandbox.paypal.com/v1/payments/payment",
      :headers => { 'Content-Type' => 'application/json' },
      :body => {
        :intent => 'sale',
        # :redirect_urls => {
        #   :return_url => "http://<return URL>"
        #   :cancel_url => "http://<cancel URL>"
        # },
        :payer => {
          :payment_method => "paypal"
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
          # :item_list => {
          #   :items => [
          #     {
          #       :quantity => "1",
          #       :name => "item 1",
          #       :price => "1",
          #       :currency => "USD",
          #       :description => "item 1 description",
          #       :tax => "1"
          #     },
          #     {
          #       :quantity => "1",
          #       :name => "item 2",
          #       :price => "1",
          #       :currency => "USD",
          #       :description => "item 2 description",
          #       :tax => "1"
          #     }
          #   ]
          # },
          # :description => "The payment transaction description.",
          # :invoice_number => "merchant invoice",
          # :custom => "merchant custom data"
        }
      }.to_json
    })
  end
end
