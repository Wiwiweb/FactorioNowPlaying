data:extend({
  {
    type = "bool-setting",
    name = "nowplaying-print-chat",
    setting_type = "runtime-per-user",
    default_value = false,
    order = "a",
  },
  {
    type = "int-setting",
    name = "nowplaying-padding-lines",
    setting_type = "runtime-per-user",
    default_value = 2,
    min_value = 0,
    max_value = 10,
    order = "b",
  },
})
