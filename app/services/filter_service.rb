# frozen_string_literal: true

# This class is used to scrape external web pages.
class FilterService
  REGEX_FOR_MOST_SINGLE_SYMBOLS = /(?<!\w)[^\w\s](?!\w)/.freeze

  attr_reader :filtered_data

  def initialize(entries: nil, filters: [])
    @entries = entries
    @filters = filters
  end

  def call
    return [] unless @entries.present? && @filters.present?

    @filtered_data = filtered_entries
  end

  private

  def filtered_entries
    filtered_entries = []
    filtered_entries = filter_titles_with_more_than_five_words(@entries) if @filters.include?('five_or_more_words_comments_desc')
    filtered_entries = filter_titles_five_or_fewer_words(@entries) if @filters.include?('five_or_fewer_words_points_desc')
    filtered_entries
  end

  def filter_titles_with_more_than_five_words(entries)
    filtered_entries = entries.select do |entry|
      entry[:title].gsub(REGEX_FOR_MOST_SINGLE_SYMBOLS, ' ').split.size > 5
    end
    sort_by_number_of_comments_desc(filtered_entries)
  end

  def filter_titles_five_or_fewer_words(entries)
    filtered_entries = entries.select do |entry|
      entry[:title].gsub(REGEX_FOR_MOST_SINGLE_SYMBOLS, ' ').split.size <= 5
    end
    sort_by_points_desc(filtered_entries)
  end

  def sort_by_number_of_comments_desc(entries)
    sorted_entries = entries.sort_by do |entry|
      (entry[:comments] || '0 comments').gsub(' comments', '')&.to_i
    end
    sorted_entries.reverse
  end

  def sort_by_points_desc(entries)
    sorted_entries = entries.sort_by do |entry|
      (entry[:score] || '0 points').gsub(' points', '')&.to_i
    end
    sorted_entries.reverse
  end
end
