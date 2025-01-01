
local awful = require("awful")
local beautiful = require("beautiful")

return {
  {
    bindings = {
      {mod = {}, button = 3, press = function() beautiful.mainmenu:toggle() end },
      {mod = {}, button = 4, press = awful.tag.viewnext },
      {mod = {}, button = 5, press = awful.tag.viewprev },
    },
  },
}
