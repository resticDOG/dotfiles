local topbar = require("ui.bar.topbar")

screen.connect_signal("request::desktop_decoration", function(s)
  s.bar = topbar(s)
end)
