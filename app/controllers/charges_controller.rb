class ChargesController < ApplicationController
  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: 100,
      description: "Galaxy Membership - #{current_user.email}",
      currency: 'usd'
    )

    flash[:notice] = "Thanks for all the fish, #{current_user.email}!"
    current_user.update_attributes(role: "premium")
    redirect_to root_path

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Galaxy Membership - #{ current_user.name }",
      amount: 100
    }
  end
  def destroy
    current_user.update_attributes(role: "standard")
    current_user.wikis.update_all(private: false)
    redirect_to wikis_path
  end

end
