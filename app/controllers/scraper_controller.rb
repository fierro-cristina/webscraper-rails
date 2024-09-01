# frozen_string_literal: true

# A controller to scrape external web pages.
class ScraperController < ApplicationController
  before_action :scrape_data

  def scraper
    @page_title = 'Rails Scraper'
  end

  def filter_data
    service =
      FilterService.new(entries: @scraped_data, filters: params[:filters])
    service.call
    @filtered_data = service.filtered_data
    save_request_data
    render :scraper
  end

  private

  def save_request_data
    require 'csv'
    CSV.open('request_log.csv', 'a') do |csv|
      csv << %w[time filters] unless File.exist?('./request_log.csv')
      csv << [Time.current, params[:filters]]
    end
  end

  def scrape_data
    service = ScraperService.new
    service.call
    @scraped_data = service.data
  end
end
