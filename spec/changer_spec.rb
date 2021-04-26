RSpec.describe Highspot::Changer do
  describe '.perform' do
    subject { described_class.new.perform(source: source, changes: changes) }

    let(:source) { JSON.load_file('spec/fixtures/source.json', symbolize_names: true) }
    let(:changes) { JSON.load_file('spec/fixtures/changes.json', symbolize_names: true) }

    it 'returns hash' do
      expect(subject).to be_a Hash
    end

    it 'adds playlist' do
      expect(subject[:playlists].last[:id]).to eq '3'
    end

    it 'removes playlist' do
      expect(subject[:playlists].first[:id]).to_not eq '1'
    end

    it 'adds song to playlist' do
      expect(subject[:playlists].first[:song_ids]).to eq %w[1 2]
    end
  end
end
