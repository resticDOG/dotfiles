local gfs = require("gears.filesystem")

local icons_path = gfs.get_configuration_dir() .. "resources/icons/"

local M = {
  icons_path = icons_path,
  --- Profile
  name = "Linkzz",
  avatar = icons_path .. "avatar.png",

  --- Modkey
  modkey = "Mod4",

  --- Default apps
  terminal = "kitty",
  file_manager = "thunar",
  browser = "microsoft-edge-stable",
  editor = "nvim",

  wallpaper = icons_path .. "../wallpapers/dark.png",
}

return M
