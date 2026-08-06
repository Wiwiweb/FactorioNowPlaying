-- Styles copied and modified from raiguard's StatsGui
-- MIT License
-- https://codeberg.org/raiguard/StatsGui/src/branch/trunk/data.lua

local styles = data.raw["gui-style"].default

styles.nowplaying_statsgui_label = {
  type = "label_style",
  font = "default-game",
  --- @diagnostic disable-next-line: undefined-global
  font_color = default_font_color,
}

styles.nowplaying_statsgui_frame = {
  type = "frame_style",
  parent = "invisible_frame",
  horizontal_flow_style = {
    type = "horizontal_flow_style",
    vertical_spacing = 0,
    horizontal_align = "right",
    horizontally_stretchable = "on",
    top_padding = 11,
    right_padding = 282,
  },
}
