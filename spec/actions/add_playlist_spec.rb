RSpec.describe Highspot::Actions::AddPlaylist do
  describe '.perform' do
    subject { described_class.new(source: source, changes: changes).perform }

    let(:source) { JSON.load_file('spec/fixtures/source.json', symbolize_names: true) }
    let(:changes) do
      [
        {
          user_id: '1',
          song_ids: ['1']
        }
      ]
    end

    it 'returns original source' do
      expect(subject[:playlists].first).to eq source[:playlists].first
    end

    it 'adds new playlist' do
      expect(subject[:playlists].length).to eq 3
    end

    it 'adds song to new playlist' do
      expect(subject[:playlists].last[:song_ids]).to eq ['1']
    end

    it 'increments id' do
      expect(subject[:playlists].last[:id]).to eq '3'
    end

    it 'does not add playlist if user does not exist' do
      changes[0][:user_id] = '999'
      expect(subject[:playlists].length).to eq 2
    end

    it 'does not add playlist if there are no songs' do
      changes[0][:song_ids] = nil
      expect(subject[:playlists].length).to eq 2
    end
  end
end
