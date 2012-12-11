require 'open-uri'
require 'nokogiri'

class TripAdvisor
	def initialize(location_id)
		@site = 'http://www.tripadvisor.com/'
		uri = location_id
		@url = "#{@site}#{uri}"
	end

	def get_new_reviews(latest_review)
		begin
		job_start_time = Time.now
		puts "Crawling: #{@url}"
		doc = Nokogiri::HTML(open(@url)).css('div#REVIEWS div.reviewSelector')

		new_reviews = []
		doc.each do |review|
			review_date = Date.parse(review.at_css('span.ratingDate').text.strip.slice(9..-1))
			review_comment = review.at_css('p.partial_entry').text.strip

			# when review_date is taking date objects, change this to just 'if review_date >= latest_review[:post_date]'
			if review_date >= Date.strptime(latest_review[:post_date], "%m/%d/%Y")
				next if review_comment == latest_review[:comment].chomp
				new_review = {}
				new_review[:post_date] = review_date
				new_review[:comment] = review_comment
				new_review[:author] = review.at_css('div.username span').text.strip
				new_review[:rating] = review.at_css('img.sprite-ratings')[:content].to_f
				new_review[:title] = review.at_css('div.quote').text.strip.slice(1..-2)
				new_review[:url] = "#{@site}" + review.at_css('div.quote a')[:href]
				new_reviews << new_review
			end
		end
		puts "Total Crawl Time: #{Time.now - job_start_time} seconds"
		
		rescue => e
			pp e.message
			pp e.backtrace
			puts "Encountered error on #{@url} page, moving on..."
		end

		new_reviews
	end
end