class ChargesController < ApplicationController

  def create
    customers = Stripe::Customer.all

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

    flash[:notice] = "Thank you for your payment, #{current_user.email}! You have 7 days to cancel your membership."
    redirect_to root_path


    if current_user.standard?
      current_user.premium!
      puts current_user.role
    end

    Charge.create!(
      user_id: current_user.id,
      charge_id: charge.id,
      amount: amount.default,
      currency: 'usd'
    )

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

  def destroy
    @wikis = Wiki.where(user_id: current_user.id)
    @charge = Charge.where(user_id: current_user.id).first
    if @charge.created_at + 7.days < Time.now
      flash[:alert] = "You can no longer cancel your membership"
      redirect_to root_path and return
    end
    #create a refund object
    re = Stripe::Refund.create(
      charge: @charge.charge_id
    )
    #remove change from applications database
    @charge.destroy
    #change role of current user
    current_user.standard!

    #make all the user's wiki's public
    @wikis.each do |wiki|
      wiki.private = false
      wiki.save
    end

    flash[:notice] = "Your account has been refunded, #{current_user.email}!"
    #redirect to home page
    redirect_to root_path
  end

end
