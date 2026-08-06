local mod_data = prototypes["mod_data"]["now-playing-ambient-sound-info"]

function get_music_track_title(player)
  local current_track = player.current_music
  if current_track and current_track ~= "" then
    local track_info = mod_data.get(current_track)
    local track_title
    if track_info then -- Mod data could be missing this info if ambient-sound was modified by another mod after now-playing
      track_title = track_info.title and track_info.title or current_track
      if track_info.variable then
        track_title = { "", track_title, " ", { "now-playing.variable" } }
      end
    else
      track_title = current_track
    end
    return track_title
  end
  return { "now-playing.no-music" }
end
