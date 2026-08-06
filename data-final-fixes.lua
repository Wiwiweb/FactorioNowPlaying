local custom_titles = {
  ["censeqs-discrepancy"] = "cenSeq’s Discrepancy",
}

-- Turns "my-song-name" into "My Song Name"
local function titleize(hyphenated_title)
  local title = hyphenated_title:gsub("-", " ")
  title = title:gsub("(%a)([%w_']*)", function(first, rest)
    return first:upper() .. rest
  end)
  return title
end

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

  if custom_titles[name] then
    sound.title = custom_titles[name]
  end

  if not sound.title then
    sound.title = titleize(name)
  end

  ambient_sound_info_table[name] = {
    title = sound.title,
    type = sound.track_type,
    planet = planet,
    variable = sound.sound == nil,
  }
  -- log(name .. " : " .. serpent.line(ambient_sound_info_table[name]))
end

data:extend({
  {
    type = "mod-data",
    name = "now-playing-ambient-sound-info",
    data = ambient_sound_info_table,
  }
})
