
local awful = require("awful")
local M = require("module.keybindings.modkeys")

return {
  {
    bindings = {
      {mod = {}, button = 1, press = function(c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
      end},

      {mod = {M.MOD}, button = 1, press = function(c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
      end},

      {mod = {M.MOD}, button = 3, press = function(c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
      end},

    },
  },
}
