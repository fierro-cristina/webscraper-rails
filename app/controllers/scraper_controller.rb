# frozen_string_literal: true

# A controller to scrape external web pages.
class ScraperController < ApplicationController
  def scraper
    @page_title = 'Rails Scraper'
    # Create a service to scrape whatever website the user wants.
    # Save scraped data in db
    # Fetch db data and display it on the view
    service = ScraperService.new
    service.call
    @scraped_data = service.data
  end
end
