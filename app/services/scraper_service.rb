# frozen_string_literal: true

# This class is used to scrape external web pages.
class ScraperService
  require 'httparty'
  require 'nokogiri'
  # require 'csv'

  attr_reader :data

  def initialize(filters: {})
    @website = 'https://news.ycombinator.com/'
    @filters = filters
  end

  def call
    @data = scrape_data_from_website
  end

  private

  def scrape_data_from_website
    response = HTTParty.get(@website)
    body = Nokogiri::HTML4(response.body)

    [scrape_ranks(body), scrape_titles(body), scrape_scores(body), scrape_comments(body)]
  end

  def scrape_ranks(body)
    body.css('.rank')&.map(&:text)
  end

  def scrape_titles(body)
    body.css('.titleline')&.map(&:text)
  end

  def scrape_scores(body)
    body.css('.score')&.map(&:text)
  end

  def scrape_comments(body)
    body.search("text()[contains('comments')]")&.map(&:text)
  end

  def filters; end

  def save_request_data; end
end
