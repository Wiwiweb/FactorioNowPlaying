local ambient_sound_info_table = {}
for name, sound in pairs(data.raw["ambient-sound"]) do

  local planet = nil
  if not sound.play_on_all_surfaces then
    if not sound.planets or not next(sound.planets) then
      planet = "space"
    elseif #sound.planets == 1 then
      planet = sound.planets[1]
    end
  end

  ambient_sound_info_table[name] = {
    title = sound.title,
    planet = planet,
  }
end

data:extend({
  {
    type = "mod-data",
    name = "now-playing-ambient-sound-info",
    data = ambient_sound_info_table,
  }
})
