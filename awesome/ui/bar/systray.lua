local wibox = require("wibox")
local utils = require("utils")
local beautiful = require("beautiful")

return function()
  -- create systray
  local systray = wibox.widget.systray()
  -- set base size
  systray:set_base_size(DPI(20))

  return wibox.widget({
    {
      {
        nil,
        layout = wibox.layout.align.horizontal,
        utils.border_container({
          widget = systray,
          margins = DPI(2),
        }),
        expand = "none",
      },
      widget = wibox.container.margin,
      left = DPI(10),
      right = DPI(10),
      top = DPI(3),
      bottom = DPI(1),
    },
    widget = wibox.container.background,
    bg = beautiful.bg_normal,
    shape = utils.rrect(DPI(4)),
  })
end
