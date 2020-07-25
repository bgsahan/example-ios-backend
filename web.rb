require 'sinatra'
require 'stripe'
# This is your real test secret API key.
Stripe.api_key = 'sk_test_51H8m9zEyfNlyyBH00NYWxfhwkbyWFx0H9jbXOHRuKtkbtb5wST42D70wEYqqookGxZqoI1dJt3ctCHDRmnu3H6Mx00pbvNWEsC'
set :static, true
set :public_folder, File.join(File.dirname(__FILE__), '.')
set :port, 4242
# Securely calculate the order amount
def calculate_order_amount(_items)
  # Replace this constant with a calculation of the order's amount
  1400
end
# An endpoint to start the payment process
post '/create-payment-intent' do
  content_type 'application/json'
  data = JSON.parse(request.body.read)
  # Create a PaymentIntent with amount and currency
  payment_intent = Stripe::PaymentIntent.create(
    amount: calculate_order_amount(data['items']),
    currency: 'usd'
  )
  {
    clientSecret: payment_intent['client_secret'],
  }.to_json
end
