local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local M = {}

--- Create a rounded rectangle shape
M.rrect = function(radius)
  return function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, radius)
  end
end

--- Create a border container with a rounded rectangle shape
M.border_container = function(args)
  return wibox.widget({
    {
      args.widget,
      margins = args.margins or DPI(4),
      widget = wibox.container.margin,
    },
    shape = args.shape or M.rrect(beautiful.border_radius),
    border_width = DPI(1.6),
    border_color = beautiful.focus,
    widget = wibox.container.background,
  })
end

M.margin_container = function(args)
  return wibox.widget({
    {
      args.widget,
      margins = args.margins or DPI(4),
      widget = wibox.container.margin,
    },
    widget = wibox.container.margin,
    margins = args.margins or 0,
    left = args.left or 0,
    right = args.right or 0,
    top = args.top or 0,
    bottom = args.bottom or 0,
  })
end

return M
