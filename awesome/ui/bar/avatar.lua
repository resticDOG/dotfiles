-- 导入所需的模块
local gears = require("gears")
local wibox = require("wibox")
local vars = require("config.vars")

-- 创建头像组件
local avatar = wibox.widget({
  {
    image = vars.avatar,
    resize = true,
    widget = wibox.widget.imagebox,
  },
  shape = gears.shape.circle, -- 设置为圆形头像
  widget = wibox.container.background,
})

-- 调整头像大小
avatar.width = DPI(30)
avatar.height = DPI(30)

return avatar
