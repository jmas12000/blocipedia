require 'amount'
class ChargesController < ApplicationController
  after_action :upgrade_user_role, only: :create
  
  # Creates a Stripe Customer object, for associating
  # with the charge
  
  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "BigMoney Membership - #{current_user.name}",
      amount: Amount.default
    }
  end
  def create
    customer = Stripe::Customer.create(
    email: current_user.email,
    card: params[:stripeToken]
  )
 
  # Where the real magic happens
  charge = Stripe::Charge.create(
    customer: customer.id, # -- this is NOT the user_id in your app
    amount: Amount.default,
    description: "BigMoney Membership - #{current_user.email}",
    currency: 'usd'
  )
 
  flash[:notice] = "Thanks for upgrading your service, #{current_user.email}! You have unlocked the capability of creating private Wikis."
  redirect_to root_path(current_user) # or wherever
  upgrade_user_role
 
  # Stripe will send back CardErrors, with friendly messages
  # when something goes wrong.
  # This `rescue block` catches and displays those errors.
  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_charge_path
  end
  
  private
  
  def upgrade_user_role
    current_user.update_attribute(:role, 'premium')
  end
end
