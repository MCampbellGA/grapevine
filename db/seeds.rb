

# Add intital user
# puts "Setting up default user login"
# user1 = User.create! :first_name => "Erik", :last_name => "Larson", :email => "erik@pickgrapevine.com", :password => 'please', :password_confirmation => 'please'
# puts "New user created: #{user1.first_name} #{user1.last_name}"


# Seed stripe plans
# Stripe can give an Stripe::InvalidRequestError: Plan already exists. If that occurs, simply move on
stripe_plans = [
  { amount: 0, interval: 'month', currency: 'usd', id: 'gv_free',  name: 'Grapevine Alerts - Free Forever Plan'},
  { amount: 3000, interval: 'month', currency: 'usd', id: 'gv_30',  name: 'Grapevine Alerts - Basic Monthly Plan (1 Location)'},
  { amount: 5000, interval: 'month', currency: 'usd', id: 'gv_50',  name: 'Grapevine Alerts - Basic Monthly Plan (3 Locations)'}
]

# If a plan is already created inside of Stripe, it will return an error.
stripe_plans.each { |plan| Stripe::Plan.create plan rescue puts "Skipping #{ plan[:name] } - Already in Stripe Plans"}

# Seed Plans table, matches what we have in Stripe
gv_free = stripe_plans[0]
gv_30 = stripe_plans[1]
gv_50 = stripe_plans[2]
Plan.find_or_create_by_identifier! :identifier => gv_free[:id], :name => gv_free[:name], :amount => gv_free[:amount], :currency => gv_free[:currency], :interval => gv_free[:interval], :location_limit => 1, :review_limit => 5
puts "Created #{gv_free[:name]} in local database"
Plan.find_or_create_by_identifier! :identifier => gv_30[:id], :name => gv_30[:name], :amount => gv_30[:amount], :currency => gv_30[:currency], :interval => gv_30[:interval], :location_limit => 1
puts "Created #{gv_30[:name]} in local database"
Plan.find_or_create_by_identifier! :identifier => gv_50[:id], :name => gv_50[:name], :amount => gv_50[:amount], :currency => gv_50[:currency], :interval => gv_50[:interval], :location_limit => 3
puts "Created #{gv_50[:name]} in local database"


# Add Sources to Source Tables
# Source(id: integer, name: string, category: string, max_rating: decimal, accepts_management_response: boolean, management_response_url: string, main_url: string, created_at: datetime, updated_at: datetime) 
Source.create! name: 'yelp', category: 'general', max_rating: 5.0, accepts_management_response: true, management_response_url: 'https://biz.yelp.com/', main_url: 'http://www.yelp.com/'
Source.create! name: 'googleplus', category: 'general', max_rating: 5.0, accepts_management_response: true, management_response_url: 'http://www.google.com/placesforbusiness', main_url: 'http://www.google.com/places/'
Source.create! name: 'opentable', category: 'restaurants', max_rating: 5.0, accepts_management_response: true, management_response_url: 'http://www.otrestaurant.com/', main_url: 'http://www.yelp.com'
Source.create! name: 'tripadvisor', category: 'general', max_rating: 5.0, accepts_management_response: true, management_response_url: 'http://www.tripadvisor.com/Owners', main_url: 'http://www.yelp.com'
Source.create! name: 'urbanspoon', category: 'restaurants', max_rating: 5.0, accepts_management_response: true, management_response_url: 'http://www.urbanspoon.com/u/signin', main_url: 'http://www.yelp.com'
