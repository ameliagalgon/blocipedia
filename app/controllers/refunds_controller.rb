class RefundsController < ApplicationController
  def create
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
    puts "YOUR WIKIS: #{@wikis}"
    @wikis.each do |wiki|
      wiki.private = false
      wiki.save
    end

    flash[:notice] = "Your account has been refunded, #{current_user.email}!"
    #redirect to home page
    redirect_to root_path

  end

  def new

  end

end
