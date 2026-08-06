local mod_data = prototypes["mod_data"]["now-playing-ambient-sound-info"]

function print_music_track(player_index)
  local player = game.get_player(player_index)
  if player and player.connected then
    local current_track = player.current_music
    if current_track and current_track ~= "" then
      local track_info = mod_data.get(current_track)
      local track_title = track_info.title and track_info.title or current_track
      if track_info.variable then
        track_title = { "", track_title, " ", {"now-playing.variable"} }
      end
      player.print({ "now-playing.now-playing", track_title },
        {
          color = { r = 148, g = 246, b = 255 },
          sound = defines.print_sound.never,
          skip = defines.print_skip.never,
          game_state = false,
        }
      )
    end
  end
end

script.on_event(defines.events.on_player_music_changed, function(event)
  print_music_track(event.player_index)
end)
