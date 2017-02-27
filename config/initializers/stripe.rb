require "stripe"
Rails.configuration.stripe = {
  publishable_key: ENV['STRIPE_TEST_PUBLISHABLE_KEY'],
  secret_key: ENV['STRIPE_TEST_SECRET_KEY']
}
 
 # Set our app-stored secret key with Stripe
Stripe.api_key = Rails.configuration.stripe[:secret_key]