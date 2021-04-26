module Highspot
  module Actions
    class AddSong < Base
      def perform
        changes.each do |item|
          song = find_by_id(:songs, item[:song_id])
          playlist = find_by_id(:playlists, item[:playlist_id])
          next if !song || !playlist

          playlist[:song_ids].push(song[:id])
        end

        source
      end
    end
  end
end
