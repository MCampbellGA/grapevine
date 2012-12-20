class AccountsController < ApplicationController

	def index
            @plan = current_user.subscription.plan
            @location = current_user.locations[0]
            @subscription = current_user.subscription

            if current_user.subscription.status_info
                  @status = current_user.subscription.status_info.capitalize
            else
                  @status = "No status info available, please contact Grapevine"
            end

            if @subscription.start_date
                  @start_date = Time.at(@subscription.start_date).to_date.strftime("%A, %B %d, %Y")
            else
                  @start_date = "No start date found, please contact Grapevine"
            end
            
	end

      def update
            @user = current_user
            @plans = Plan.all
            @location_limit = @user.plan.location_limit
            @review_limit = @user.plan.review_limit
            @location = @user.locations[0]
            @subscription = @user.subscription

            if current_user.subscription.status_info
                  @status = current_user.subscription.status_info.capitalize
            else
                  @status = "No status info available, please contact Grapevine"
            end

            if @subscription.start_date
                  @start_date = Time.at(@subscription.start_date).to_date.strftime("%A, %B %d, %Y")
            else
                  @start_date = "No start date found, please contact Grapevine"
            end
      end

      def billing
            @user = current_user
            @subscription = @user.subscription
      end

end
