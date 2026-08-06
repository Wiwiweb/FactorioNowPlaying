function player_init(player, player_index)
  storage.players[player_index] = {
    settings = {},
  }
  update_settings(player, storage.players[player_index])
end

function update_settings(player, player_table)
  local mod_settings = player.mod_settings
  local settings = {
    padding_lines = mod_settings["nowplaying-padding-lines"].value,
  }
  player_table.settings = settings
end
