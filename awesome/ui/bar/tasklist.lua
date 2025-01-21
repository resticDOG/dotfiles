local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local utils = require("utils")

return function(s)
  local tasklist = awful.widget.tasklist({
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    layout = {
      spacing = 5,
      spacing_widget = {
        color = beautiful.bg_normal,
        shape = gears.shape.rectangle,
        widget = wibox.widget.separator,
      },
      layout = wibox.layout.fixed.horizontal,
    },
    widget_template = {
      {
        {
          id = "icon_role",
          widget = wibox.widget.imagebox,
          resize = true,
          forced_width = DPI(24),
          forced_height = DPI(24),
        },
        margins = 5,
        widget = wibox.container.margin,
      },
      id = "background_role",
      widget = wibox.container.background,
    },
    buttons = {
      awful.button({}, 1, function(c)
        c:activate({ context = "tasklist", action = "toggle_minimization" })
      end),
      awful.button({}, 3, function()
        awful.menu.client_list({ theme = { width = 250 } })
      end),
      awful.button({}, 4, function()
        awful.client.focus.byidx(-1)
      end),
      awful.button({}, 5, function()
        awful.client.focus.byidx(1)
      end),
    },
  })
  return wibox.widget({
    {
      {
        nil,
        layout = wibox.layout.align.horizontal,
        utils.border_container({
          widget = tasklist,
          margins = DPI(2),
        }),
        expand = "none",
      },
      widget = wibox.container.margin,
      left = DPI(10),
      right = DPI(10),
    },
    widget = wibox.container.background,
    bg = beautiful.bg_normal,
    shape = utils.rrect(DPI(4)),
  })
end
