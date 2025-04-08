local awful = require("awful")

local utility = {}

utility.protectedResize = function (c, x, y, w, h)

    local g = c:geometry()
    local screen = awful.screen.focused()
    local screen_width = screen.geometry.width
    local screen_height = screen.geometry.height

    if g.x + x < 0 or
      g.y + y < 0 or
      g.x + x >= screen_width or
      g.y + y >= screen_height or
      g.x + x + g.width >= screen_width or
      g.y + y + g.height >= screen_height or
      g.width + w < 0 or
      g.height + h < 0 or
      g.width + w >= screen_width or
      g.height + h >= screen_height then
      return
    end

    c:relative_move(x,y,w,h)
end

return utility
