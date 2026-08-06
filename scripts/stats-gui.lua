-- GUI code copied and modified from raiguard's StatsGui
-- MIT License
-- https://codeberg.org/raiguard/StatsGui/src/branch/trunk/scripts/stats-gui.lua

require("scripts/util")

function gui_build(player, player_table)
  local style = "nowplaying_statsgui_frame"
  local window = player.gui.screen.add({
    type = "frame",
    style = style,
    direction = "horizontal",
    ignored_by_interaction = true,
    visible = player.controller_type ~= defines.controllers.cutscene,
  })

  local label = window.add({
    type = "label",
    style = "nowplaying_statsgui_label",
    caption = { "", "♫ ", get_music_track_title(player) }
  })
  player_table.stats_window = window
  player_table.stats_label = label

  gui_update(player, player_table)
end

function gui_destroy(player_table)
  local stats_window = player_table.stats_window
  if stats_window and stats_window.valid then
    stats_window.destroy()
    player_table.stats_window = nil
  end
end

--- @param player LuaPlayer
function gui_update(player, player_table)
  local window = player_table.stats_window
  if not window or not window.valid then
    gui_build(player, player_table)
    window = player_table.stats_window
  end

  player_table.stats_label.caption = { "", "♫ ", get_music_track_title(player) }

  local in_remote = player.controller_type == defines.controllers.remote
  local in_train_gui = player.opened_gui_type == defines.gui_type.entity and player.opened.type == "locomotive"
  local in_cutscene = player.controller_type == defines.controllers.cutscene
  local location = window.location
  location.y = in_remote and (36 * player.display_scale) or 0
  location.y = location.y + (player_table.settings.padding_lines * 20 * player.display_scale)
  window.location = location
  window.style.width = (player.display_resolution.width / player.display_scale)
  window.visible = not in_train_gui and not in_cutscene
end

--- @param player LuaPlayer
function gui_update_caption_only(player, player_table)
  player_table.stats_label.caption = { "", "♫ ", get_music_track_title(player) }
end
