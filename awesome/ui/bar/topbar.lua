local awful = require("awful")
local wibox = require("wibox")

-- custom widgets
local taglist = require("ui.bar.taglist")
local tasklist = require("ui.bar.tasklist")
local avatar = require("ui.bar.avatar")
local systray = require("ui.bar.systray")

return function(s)
  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()

  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox({
    screen = s,
    buttons = {
      awful.button({}, 1, function()
        awful.layout.inc(1)
      end),
      awful.button({}, 3, function()
        awful.layout.inc(-1)
      end),
      awful.button({}, 4, function()
        awful.layout.inc(-1)
      end),
      awful.button({}, 5, function()
        awful.layout.inc(1)
      end),
    },
  })

  s.mytasklist = tasklist(s)

  -- Create the wibox
  return awful.wibar({
    position = "top",
    screen = s,
    height = DPI(30),
    widget = {
      layout = wibox.layout.align.horizontal,
      { -- Left widgets
        layout = wibox.layout.fixed.horizontal,
        taglist(s),
        s.mypromptbox,
      },
      s.mytasklist, -- Middle widget
      { -- Right widgets
        layout = wibox.layout.fixed.horizontal,
        mykeyboardlayout,
        {

          layout = wibox.layout.align.horizontal,
          systray(),
          margins = DPI(20),
          widget = wibox.container.margin,
        },
        mytextclock,
        avatar,
        s.mylayoutbox,
      },
    },
  })
end
