require_relative '../vineyard/opentable.rb'
require_relative '../vineyard/yelp.rb'
require_relative '../vineyard/googleplus.rb'
require_relative '../vineyard/urbanspoon.rb'
require_relative '../vineyard/tripadvisor.rb'
# require_relative "../../app/models/review"
require_relative "../../app/models/location"

namespace :get_source_location_uri do
	desc 'Find Yelp ID# : term, lat, long (Assumes 1st is right)'
	task :yelp, [:term, :lat, :long] => :environment do |t, args|
		term = args[:term]
		lat = args[:lat]
		long = args[:long]
		puts "Searching for Yelp ID using term: #{term}"
		run = Yelp.new
		source_location_uri = run.get_location_id(term, lat, long)
		puts "Your Yelp source_location_uri for #{term} is: #{source_location_uri}"	

	end

	desc 'Find Google ID# : term, lat, long (Assumes 1st is right)'
	task :google, [:term, :lat, :long] => :environment do |t, args|
		term = args[:term]
		lat = args[:lat]
		long = args[:long]
		puts "Searching for Google ID using term: #{term}"
		run = Google.new
		source_location_uri = run.get_location_id(term, lat, long)
		puts "Your Google source_location_uri for #{term} is: #{source_location_uri}"	
	end
end

namespace :get_new_reviews do
	desc "Check All Locations for New Reviews Across All Sites"
	task :all => :environment do
		zinc = Location.find('13')
		# Check OpenTable
		Rake::Task['crawl:opentable'].reenable
		Rake::Task['crawl:opentable'].invoke(zinc)
	end
	
	desc "Check Yelp for new reviews"
	task :yelp => :environment do
		puts "Getting all associated source_location_uris of Yelp"
		source = Source.find_by_name('yelp')
		source_vines = source.vines
		source_vines.each do |vine|
			source_location_uri = vine.source_location_uri
			location = vine.location
			reviews = vine.source.reviews
			if reviews.empty?
				last_30_days_ago = Date.today - 30
				latest_review = {:post_date => last_30_days_ago, :comment => '' }
			else
				last_review = reviews.order('post_date DESC').first
				latest_review = {:post_date => last_review[:post_date], :comment => last_review[:comment]}
			end
			puts "Searching for new reviews at: #{source_location_uri}"
			run = Yelp.new
			response = run.get_new_reviews(latest_review, source_location_uri)

			review_count = 0
			response.each do |review|
				new_review = Review.new(:location_id => location.id,
										:source_id   => source.id, 
									    :post_date   => review[:post_date],
									    :comment     => review[:comment],
									    :author	     => review[:author],
									    :rating      => review[:rating],
									    :url         => review[:url] )
				new_review.save!
				review_count += 1
			end
			puts "Finished adding #{review_count} new reviews for: #{location.name}"
		end
	end
	
	desc "Check OpenTable for new reviews"
	task :opentable => :environment do
		puts "Getting all associated source_location_uris of OpenTable"
		source = Source.find_by_name('opentable')
		source_vines = source.vines
		source_vines.each do |vine|
			source_location_uri = vine.source_location_uri
			location = vine.location
			reviews = vine.source.reviews
			if reviews.empty?
				last_30_days_ago = Date.today - 30
				latest_review = {:post_date => last_30_days_ago, :comment => '' }
			else
				last_review = reviews.order('post_date DESC').first
				latest_review = {:post_date => last_review[:post_date], :comment => last_review[:comment]}
			end
			puts "Searching for new reviews at: #{location.name}"
			run = OpenTable.new
			response = run.get_new_reviews(latest_review, source_location_uri)
			review_count = 0
			response.each do |review|
				new_review = Review.new(:location_id => location.id,
										:source_id   => source.id, 
									    :post_date   => review[:post_date],
									    :comment     => review[:comment],
									    :author	     => review[:author],
									    :rating      => review[:rating],
									    :title       => review[:title],
									    :url         => review[:url] )
				new_review.save!
				review_count += 1
			end
			puts "Finished adding #{review_count} new reviews for: #{location.name}"
		end
	end

	desc "Check GooglePlus for new reviews"
	task :google => :environment do
		puts "Getting all associated source_location_uris of Google"
		source = Source.find_by_name('googleplus')
		source_vines = source.vines
		source_vines.each do |vine|
			source_location_uri = vine.source_location_uri
			location = vine.location
			reviews = vine.source.reviews
			if reviews.empty?
				last_30_days_ago = Date.today - 30
				latest_review = {:post_date => last_30_days_ago, :comment => '' }
			else
				last_review = reviews.order('post_date DESC').first
				latest_review = {:post_date => last_review[:post_date], :comment => last_review[:comment]}
			end
			puts "Searching for new reviews at: #{location.name}"
			run = Google.new
			response = run.get_new_reviews(latest_review, source_location_uri)
			review_count = 0
			response.each do |review|
				new_review = Review.new(:location_id 		=> location.id,
										:source_id   		=> source.id, 
									    :post_date   		=> review[:post_date],
									    :comment     		=> review[:comment],
									    :author	     		=> review[:author],
									    :author_url  		=> review[:author_url],
									    :rating      		=> review[:rating],
									    :rating_description => review[:rating_description],
									    :title       		=> review[:title],
									    :url         		=> review[:url] )
				new_review.save!
				review_count += 1
			end
			puts "Finished adding #{review_count} new reviews for: #{location.name}"
		end

	end

	desc "Check UrbanSpoon for new reviews"
	task :urbanspoon => :environment do
		puts "Getting all associated source_location_uris of UrbanSpoon"
		source = Source.find_by_name('urbanspoon')
		source_vines = source.vines
		source_vines.each do |vine|
			source_location_uri = vine.source_location_uri
			location = vine.location
			reviews = vine.source.reviews
			if reviews.empty?
				last_30_days_ago = Date.today - 30
				latest_review = {:post_date => last_30_days_ago, :comment => '' }
			else
				last_review = reviews.order('post_date DESC').first
				latest_review = {:post_date => last_review[:post_date], :comment => last_review[:comment]}
			end
			puts "Searching for new reviews at: #{location.name}"
			run = UrbanSpoon.new
			response = run.get_new_reviews(latest_review, source_location_uri)
			debugger
			review_count = 0
			response.each do |review|
				new_review = Review.new(:location_id => location.id,
										:source_id   => source.id, 
									    :post_date   => review[:post_date],
									    :comment     => review[:comment],
									    :author	     => review[:author],
									    :rating      => review[:rating],
									    :title       => review[:title],
									    :url         => review[:url] )
				new_review.save!
				review_count += 1
			end
			puts "Finished adding #{review_count} new reviews for: #{location.name}"
		end
	end

	desc "Check TripAdvisor for new reviews"
	task :tripadvisor => :environment do
		puts "Getting all associated source_location_uris of TripAdvisor"
		source = Source.find_by_name('tripadvisor')
		source_vines = source.vines
		source_vines.each do |vine|
			source_location_uri = vine.source_location_uri
			location = vine.location
			reviews = vine.source.reviews
			if reviews.empty?
				last_30_days_ago = Date.today - 30
				latest_review = {:post_date => last_30_days_ago, :comment => '' }
			else
				last_review = reviews.order('post_date DESC').first
				latest_review = {:post_date => last_review[:post_date], :comment => last_review[:comment]}
			end
			puts "Searching for new reviews at: #{location.name}"
			run = TripAdvisor.new
			response = run.get_new_reviews(latest_review, source_location_uri)
			review_count = 0
			response.each do |review|
				new_review = Review.new(:location_id => location.id,
										:source_id   => source.id, 
									    :post_date   => review[:post_date],
									    :comment     => review[:comment],
									    :author	     => review[:author],
									    :rating      => review[:rating],
									    :title       => review[:title],
									    :url         => review[:url] )
				new_review.save!
				review_count += 1
			end
			puts "Finished adding #{review_count} new reviews for: #{location.name}"
		end
	end

end