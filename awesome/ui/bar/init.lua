local topbar = require("ui.bar.topbar")
local avatar = require("ui.bar.avatar")

screen.connect_signal("request::desktop_decoration", function(s)
  s.bar = topbar(s)
end)
