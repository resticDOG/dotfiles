---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local rnotification = require("ruled.notification")
local gears = require("gears")
local gfs = require("gears.filesystem")

local dpi = xresources.apply_dpi

local utils = require("utils")
local vars = require("config.vars")
local themes_path = gfs.get_themes_dir()

local theme = {}

--- Icons
theme.taglist_icon = vars.icons_path .. "tag-inactive.png"
theme.taglist_icon_selected = vars.icons_path .. "tag-active.png"
theme.taglist_icon_urgent = vars.icons_path .. "tag-urgent.png"

local main_color = "#25a167"

theme.font_name = "MiSans"
theme.mono_font_name = "JetBrainsMono Nerd Font"
theme.font = theme.font_name .. " 8"
theme.mono_font = theme.mono_font_name .. " 8"

theme.bg_normal = "#223167a0"
theme.bg_focus = "#ffffff28"
theme.bg_urgent = main_color
theme.accent = main_color
theme.focus = theme.bg_focus
theme.bg_minimize = "#444444"
theme.bg_systray = theme.bg_normal

theme.fg_normal = "#f3f3f3"
theme.fg_focus = "#f3f3f3"
theme.fg_urgent = "#ffffff"
theme.fg_minimize = "#ffffff"

theme.useless_gap = dpi(4)
theme.border_width = dpi(2)
theme.border_radius = dpi(5)
theme.widget_radius = dpi(5)
theme.client_border_radius = dpi(12)
theme.widget_radius = theme.border_radius
theme.border_color_normal = "#000000"
theme.border_color_active = "#535d6c"
theme.border_color_marked = "#91231c"

-- Systray
theme.systray_icon_spacing = dpi(4)
theme.systray_max_rows = 1
theme.bg_systray = theme.bg_focus

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
theme.tasklist_fg_normal = "#d3d3d3"
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
theme.taglist_spacing = dpi(2)
theme.taglist_shape = utils.rrect(theme.widget_radius)
theme.taglist_squares_sel = nil
theme.taglist_squares_unsel = nil

theme.taglist_bg_focus = theme.bg_focus
theme.taglist_fg_focus = theme.fg_focus

-- theme.taglist_bg_urgent = theme.uranus .. "B7"
-- theme.taglist_fg_urgent = theme.wibar_bg
--
-- theme.taglist_bg_occupied = theme.wibar_bg
-- theme.taglist_fg_occupied = theme.xforeground .. "F0"
--
-- theme.taglist_bg_empty = theme.black
-- theme.taglist_fg_empty = theme.xbackground

-- theme.taglist_bg_volatile = theme.jupiter

-- theme.taglist_icon_empty = icon_path .. "taglist/taglist-empty.png"
-- theme.taglist_icon_urgent = icon_path .. "taglist/taglist-urgent.png"
-- theme.taglist_icon_home = icon_path .. "taglist/taglist-home.png"

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path .. "default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width = dpi(100)

--- Hotkeys Pop
theme.hotkeys_bg = "#3e3e3eF0"
theme.hotkeys_fg = "#ffffff"
theme.hotkeys_border_color = theme.bg_focus
theme.hotkeys_border_width = theme.border_width
theme.hotkeys_modifiers_fg = main_color
theme.hotkeys_font = theme.mono_font_name .. " 10"
theme.hotkeys_description_font = theme.mono_font_name .. " 9"
theme.hotkeys_group_margin = dpi(10)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = themes_path .. "default/titlebar/close_focus.png"
theme.titlebar_close_button_focus = themes_path .. "default/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themes_path .. "default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus = themes_path .. "default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path .. "default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive = themes_path .. "default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path .. "default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active = themes_path .. "default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path .. "default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive = themes_path .. "default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path .. "default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active = themes_path .. "default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path .. "default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive = themes_path .. "default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path .. "default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active = themes_path .. "default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path .. "default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive = themes_path .. "default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path .. "default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active = themes_path .. "default/titlebar/maximized_focus_active.png"

theme.wallpaper = themes_path .. "default/background.png"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path .. "default/layouts/fairhw.png"
theme.layout_fairv = themes_path .. "default/layouts/fairvw.png"
theme.layout_floating = themes_path .. "default/layouts/floatingw.png"
theme.layout_magnifier = themes_path .. "default/layouts/magnifierw.png"
theme.layout_max = themes_path .. "default/layouts/maxw.png"
theme.layout_fullscreen = themes_path .. "default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path .. "default/layouts/tilebottomw.png"
theme.layout_tileleft = themes_path .. "default/layouts/tileleftw.png"
theme.layout_tile = themes_path .. "default/layouts/tilew.png"
theme.layout_tiletop = themes_path .. "default/layouts/tiletopw.png"
theme.layout_spiral = themes_path .. "default/layouts/spiralw.png"
theme.layout_dwindle = themes_path .. "default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path .. "default/layouts/cornernww.png"
theme.layout_cornerne = themes_path .. "default/layouts/cornernew.png"
theme.layout_cornersw = themes_path .. "default/layouts/cornersww.png"
theme.layout_cornerse = themes_path .. "default/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

-- Set different colors for urgent notifications.
rnotification.connect_signal("request::rules", function()
  rnotification.append_rule({
    rule = { urgency = "critical" },
    properties = { bg = "#ff0000", fg = "#ffffff" },
  })
end)

return theme
