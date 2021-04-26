module Highspot
  module Actions
    class RemovePlaylist < Base
      def perform
        changes.each do |playlist|
          playlist_to_delete = find_by_id(:playlists, playlist[:id])
          next unless playlist_to_delete

          source[:playlists].delete playlist_to_delete
        end

        source
      end
    end
  end
end
