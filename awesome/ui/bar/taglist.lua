local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local utils = require("utils")

--- Update taglist callback
local update_callback = function(self, c3, _, _)
  if c3.selected then --- Selected
    self:get_children_by_id("index_role")[1].image = beautiful.taglist_icon_selected
  elseif #c3:clients() == 0 then --- Empty
    self:get_children_by_id("index_role")[1].image = beautiful.taglist_icon
  else --- Normal
    self:get_children_by_id("index_role")[1].image = beautiful.taglist_icon
  end
end

-- Create taglist callback
local create_callback = function(self, c3, _, _)
  update_callback(self, c3, _, _)
  self:connect_signal("mouse::enter", function()
    if self.bg ~= beautiful.bg_urgent then
      self.backup = self.bg
      self.has_backup = true
    end
    self.bg = beautiful.bg_urgent
  end)
  self:connect_signal("mouse::leave", function()
    if self.has_backup then
      self.bg = self.backup
    end
  end)
end

local taglist_buttons = {
  awful.button({}, 1, function(t)
    t:view_only()
  end),
  awful.button({ MODKEY }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  awful.button({}, 3, awful.tag.viewtoggle),
  awful.button({ MODKEY }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),
  awful.button({}, 4, function(t)
    awful.tag.viewprev(t.screen)
  end),
  awful.button({}, 5, function(t)
    awful.tag.viewnext(t.screen)
  end),
}

local taglist = function(s)
  --- Tag
  awful.tag({ "1", "2", "3", "4", "5", "6" }, s, awful.layout.layouts[1])

  -- Create a custom taglist
  local custom_taglist = awful.widget.taglist({
    screen = s,
    filter = awful.widget.taglist.filter.all,
    widget_template = {
      {
        {
          {
            id = "index_role",
            image = beautiful.taglist_icon,
            widget = wibox.widget.imagebox,
          },
          layout = wibox.layout.fixed.horizontal,
        },
        margins = DPI(2),
        widget = wibox.container.margin,
      },
      id = "background_role",
      widget = wibox.container.background,
      -- Add support for hover colors and an index label
      create_callback = create_callback,
      update_callback = update_callback,
    },
    buttons = taglist_buttons,
  })

  return wibox.widget({
    {
      {
        nil,
        layout = wibox.layout.align.horizontal,
        utils.border_container({
          widget = custom_taglist,
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

return taglist
