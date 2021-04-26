module Highspot
  module Actions
    class AddPlaylist < Base
      def perform
        changes.each do |playlist|
          next unless find_by_id(:users, playlist[:user_id])

          new_playlist = build_playlist(**playlist)
          next unless new_playlist

          source[:playlists].push(new_playlist)
        end

        source
      end

      private

      def build_playlist(user_id:, song_ids:)
        existent_song_ids = song_ids&.select { |song_id| find_by_id(:songs, song_id) }
        next_id = (source[:playlists].last[:id].to_i + 1).to_s
        return unless existent_song_ids&.any?

        {
          id: next_id.to_s,
          user_id: user_id,
          song_ids: existent_song_ids
        }
      end
    end
  end
end
