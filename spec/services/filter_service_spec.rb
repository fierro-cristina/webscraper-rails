require 'rails_helper'

def scraped_data
  service = ScraperService.new
  service.call
  service.data
end

def string_to_integer(string, delete_str)
  string.delete(delete_str).to_i
end

def create_filter_service(entries: nil, filters: [])
  FilterService.new(entries: entries, filters: filters)
end

RSpec.describe FilterService, type: :service do
  let!(:entries) { scraped_data }

  describe '#filtered_entries' do
    context 'with five_or_more_words_comments_desc filter' do
      subject do
        service = create_filter_service(
          entries: entries, filters: %w[five_or_more_words_comments_desc]
        )
        service.call
        service.filtered_data
      end
      let!(:comments) do
        subject.map do |e|
          string_to_integer(e[:comments] || '0 comments', ' comments')
        end
      end

      it { is_expected.to be_present }

      it 'loads titles with more than 5 words' do
        expect(subject.all? { |entry| entry[:title].split.size > 5 }).to eq(true)
      end

      it 'sorts results by number of comments' do
        expect(comments.first > comments.last).to eq(true)
      end
    end

    context 'with five_or_fewer_words_points_desc filter' do
      subject do
        service = create_filter_service(
          entries: entries, filters: %w[five_or_fewer_words_points_desc]
        )
        service.call
        service.filtered_data
      end
      let!(:points) do
        subject.map do |e|
          string_to_integer(e[:score] || '0 points', ' points')
        end
      end

      it { is_expected.to be_present }

      it 'loads titles with 5 or fewer words' do
        expect(
          subject.all? { |entry| entry[:title].gsub(FilterService::REGEX_FOR_MOST_SINGLE_SYMBOLS, ' ').split.size <= 5 }
        ).to eq(true)
      end

      it 'sorts results by number of points' do
        expect(points.first > points.last).to eq(true)
      end
    end
  end
end
