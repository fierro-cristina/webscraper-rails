# frozen_string_literal: true

# This class is used to scrape external web pages.
class ScraperService
  require 'httparty'
  require 'nokogiri'

  attr_reader :data

  def initialize
    @website = 'https://news.ycombinator.com/'
  end

  def call
    @data = scrape_data_from_website
  end

  private

  def scrape_data_from_website
    response = HTTParty.get(@website)
    @body = Nokogiri::HTML4(response.body)
    @first_30_entries = first_30_entries

    @first_30_entries
  end

  def first_30_entries
    (0...30).to_a.map do |i|
      {
        rank: scrape_ranks[i],
        title: scrape_titles[i],
        score: scrape_scores[i],
        comments: scrape_comments[i]
      }
    end
  end

  def scrape_ranks
    @body.css('.rank')&.first(30)&.map(&:text)
  end

  def scrape_titles
    @body.css('.titleline')&.first(30)&.map(&:text)
  end

  def scrape_scores
    @body.css('.score')&.first(30)&.map(&:text)
  end

  def scrape_comments
    @body.xpath(".//text()[contains(., 'comments')]")&.first(30)&.map(&:text)
  end
end
