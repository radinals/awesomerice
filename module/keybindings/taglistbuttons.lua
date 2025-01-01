
local awful = require("awful")
local M = require("module.keybindings.modkeys")

return {
  {
    bindings = {
      {mod = {}, button = 1, press = function(t) t:view_only() end},

      { mod = { M.MOD }, button = 1,
        press = function(t)
          if client.focus then
            client.focus:move_to_tag(t)
          end
        end },

      {mod = {}, button = 3, press = awful.tag.viewtoggle },

      { mod = { M.MOD }, button = 3,
        press = function(t)
          if client.focus then
            client.focus:toggle_tag(t)
          end
        end },

      {mod = {}, button = 4, press = function(t) awful.tag.viewnext(t.screen) end},
      {mod = {}, button = 5, press = function(t) awful.tag.viewprev(t.screen) end},

    },
  },
}
