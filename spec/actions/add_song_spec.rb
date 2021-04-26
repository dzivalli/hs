RSpec.describe Highspot::Actions::AddSong do
  describe '.perform' do
    subject { described_class.new(source: source, changes: changes).perform }

    let(:source) { JSON.load_file('spec/fixtures/source.json', symbolize_names: true) }
    let(:changes) do
      [
        {
          song_id: '2',
          playlist_id: '1'
        }
      ]
    end

    it 'returns original source' do
      expect(subject[:playlists].first).to eq source[:playlists].first
    end

    it 'adds song to playlist' do
      expect(subject[:playlists].first[:song_ids]).to eq %w[1 2]
    end

    it 'does not add song to playlist if song does not exist' do
      changes[0][:song_id] = '3'
      expect(subject[:playlists].first[:song_ids]).to eq ['1']
    end

    it 'does not add song to playlist if playlist does not exist' do
      changes[0][:playlist_id] = '3'
      expect(subject[:playlists].first[:song_ids]).to eq ['1']
    end
  end
end
