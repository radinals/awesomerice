

local awful = require("awful")

return {
  {
    group = "Tasklist",
    bindings = {
      {mod = {}, button = 1, press = function(c)
        if c == client.focus then
          c.minimized = true
        else
          c:emit_signal(
          "request::activate",
          "tasklist",
          {raise = true}
          )
        end
      end},

      {mod = {}, button = 3, press = function()
        awful.menu.client_list({ theme = { width = 250 } })
      end},

      {mod = {}, button = 4, press = function()
        awful.client.focus.byidx(1)
      end},

      {mod = {}, button = 5, press = function()
        awful.client.focus.byidx(-1)
      end},

    },
  },
}
