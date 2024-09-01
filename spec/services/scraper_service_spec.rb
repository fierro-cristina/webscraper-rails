require 'rails_helper'

RSpec.describe ScraperService, type: :service do
  describe '#scrape_data_from_website' do
    subject do
      service = ScraperService.new
      service.call
      service.data
    end

    it { is_expected.to be_present }

    it 'returns an array of objects' do
      expect(subject).to be_an(Array)
      expect(subject.first).to be_a(Hash)
    end

    it 'contains 30 entries' do
      expect(subject.size).to eq(30)
    end

    it 'loads rank, title, score and comments' do
      expect(subject.first.keys.sort).to eq(%i[rank title score comments].sort)
    end

    it 'loads rank, title, score and comments' do
      expect(subject.first.keys.sort).to eq(%i[rank title score comments].sort)
    end
  end
end
