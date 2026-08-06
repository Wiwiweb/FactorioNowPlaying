require("scripts/util")
require("scripts/stats-gui")
require("scripts/player-data")

function print_music_track(player)
  local track_title = get_music_track_title(player)
  if track_title ~= "" then
    player.print({ "", "[font=default-semibold]", { "now-playing.now-playing" }, "[/font] ", track_title },
      {
        color = { r = 148, g = 246, b = 255 },
        sound = defines.print_sound.never,
        skip = defines.print_skip.never,
        game_state = false,
      })
  end
end

script.on_init(function()
  storage.players = {}
  for i, player in pairs(game.players) do
    player_init(player, i)
    gui_build(player, storage.players[i])
  end
end)

script.on_event(defines.events.on_player_created, function(event)
  local player = game.get_player(event.player_index)
  player_init(player, event.player_index)
  gui_build(player, storage.players[event.player_index])
end)

script.on_event(defines.events.on_player_removed, function(event)
  storage.players[event.player_index] = nil
end)


script.on_event(defines.events.on_runtime_mod_setting_changed, function(event)
  if string.sub(event.setting, 1, 10) ~= "nowplaying" then
    return
  end

  local player = game.get_player(event.player_index)
  if player then
    local player_table = storage.players[event.player_index]
    update_settings(player, player_table)
    gui_destroy(player_table)
    gui_build(player, player_table)
  end
end)

script.on_event(defines.events.on_player_controller_changed, function(event)
  local player = game.get_player(event.player_index)
  if not player then
    return
  end
  local player_table = storage.players[event.player_index]
  if not player_table then
    return
  end
  gui_update(player, player_table)
end)

script.on_event(
  { defines.events.on_player_display_resolution_changed, defines.events.on_player_display_scale_changed },
  --- @param e EventData.on_player_display_resolution_changed|EventData.on_player_display_scale_changed
  function(e)
    local player = game.get_player(e.player_index)
    if not player then
      return
    end
    local player_table = storage.players[e.player_index]
    gui_update(player, player_table)
  end
)


script.on_event(defines.events.on_player_music_changed, function(event)
  local player = game.get_player(event.player_index)
  if player and player.connected then
    local player_table = storage.players[event.player_index]
    gui_update_caption_only(player, player_table)
    if player_table.settings.print_chat then
      print_music_track(player)
    end
  end
end)
