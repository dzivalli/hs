require 'highspot/actions/base'
require 'highspot/actions/add_playlist'
require 'highspot/actions/remove_playlist'
require 'highspot/actions/add_song'

module Highspot
  class Changer
    ACTIONS = {
      add_playlist: Highspot::Actions::AddPlaylist,
      remove_playlist: Highspot::Actions::RemovePlaylist,
      add_song: Highspot::Actions::AddSong
    }.freeze

    def perform(source:, changes:)
      changes.each do |key, value|
        ACTIONS[key].new(source: source, changes: value).perform
      end

      source
    end
  end
end
