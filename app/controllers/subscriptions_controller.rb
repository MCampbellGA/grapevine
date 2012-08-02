class SubscriptionsController < ApplicationController

  def create
  	@subscription 		= Subscription.new params[:subscription]
  	user				= User.create! params[:user]
  	@subscription.user  = user
    # @location = user.locations.build(params[:location])
    # @location.save!
  	user.locations << Location.create!(params[:location])
    #debugger


  	@plan = Plan.find params[:subscription][:plan_id]

  	if @subscription.save_without_payment
  		# flash[:success]	= "Thank you for signup for your 30 Day Free Trial with Grapevine!"
  		redirect_to thankyou_path
  		# Deliver the Free signup email to new user
	    #NotifyMailer.free_signup(@subscription.user).deliver
	    # Send noticiation to internal team about new customer
	    #NotifyMailer.new_customer(@subscription.user).deliver
  	else
  		flash.now[:error] = "Unable to add your subcription, this has been reported to the Grapevine team"
  		render template: 'static_pages#signup'
  	end

  end

end