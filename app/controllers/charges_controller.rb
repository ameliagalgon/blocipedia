class ChargesController < ApplicationController

  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    amount = Amount.instance

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: amount.default,
      description: "Blocipedia Membership - #{current_user.email}",
      currency: 'usd'
    )

    flash[:notice] = "Thank you for your payment, #{current_user.email}!"
    redirect_to root_path

    if current_user.standard?
      current_user.premium!
      puts current_user.role
    end

  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_charge_path
  end

  def new
    amount = Amount.instance
    @stripe_btn_data = {
      key: "#{Rails.configuration.stripe[:publishable_key]}",
      description: "Blocipedia Membership - #{current_user.email}",
      amount: amount.default
    }

  end
end
