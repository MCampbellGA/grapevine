ActiveAdmin.register User do
	actions :index, :show, :edit, :destroy
	scope :no_stripe_customer_token
	index do
		h2 :style => "line-height:26px; width:65%;" do 
			'Users can be edited, but deletion will not delete an associating location. 
			New users must be created inside of the main web app, so that Stripe customer tokens are assigned.'
		end
		selectable_column
		column :id
		column :first_name
		column :last_name
		column :email
		column 'Associating Stripe Token' do |user|
			"#{user.subscription.stripe_customer_token}"
		end
		column :phone_number
		default_actions
	end
end
