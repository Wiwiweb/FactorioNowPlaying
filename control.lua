function print_music_track(player_index)
    local player = game.get_player(player_index)
    if player and player.connected then
        local current_track = player.current_music
        if current_track and current_track ~= "" then
            player.print({"now-playing.now-playing", current_track},
                {
                    color = {r=148, g=246, b=255},
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
