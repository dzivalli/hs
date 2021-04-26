RSpec.describe Highspot::Actions::RemovePlaylist do
  describe '.perform' do
    subject { described_class.new(source: source, changes: changes).perform }

    let(:source) { JSON.load_file('spec/fixtures/source.json', symbolize_names: true) }
    let(:changes) { [{ id: '1' }] }

    it 'removes playlist' do
      expect(subject[:playlists].length).to eq 1
    end

    it 'does not remove playlist if it does not exist' do
      changes[0][:id] = '999'
      expect(subject[:playlists].length).to eq 2
    end
  end
end
