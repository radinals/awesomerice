
local awful = require("awful")
local M = require("module.keybindings.modkeys")
local protectedResize = require("module.keybindings.utility").protectedResize

return {
  {
    group = "Resize",
    bindings = {
      {mod = { M.MOD, M.SHIFT }, key = "Left", press = function(c) protectedResize(c, 0, 0, -10, 0) end, desc = "Resize left"},
      {mod = { M.MOD, M.SHIFT }, key = "Right",press = function(c) protectedResize(c, 0, 0, 10, 0) end, desc = "Resize right"},
      {mod = { M.MOD, M.SHIFT }, key = "Up",   press = function(c) protectedResize(c, 0, 0, 0, -10) end, desc = "Resize up"},
      {mod = { M.MOD, M.SHIFT }, key = "Down", press = function(c) protectedResize(c, 0, 0, 0, 10) end, desc = "Resize down"},
      {mod = { M.MOD }, key = "Down",          press = function(c) protectedResize(c, 0, 10, 0, 0) end, desc = "Move down"},
      {mod = { M.MOD }, key = "Up",            press = function(c) protectedResize(c, 0, -10, 0, 0) end, desc = "Move up"},
      {mod = { M.MOD }, key = "Left",          press = function(c) protectedResize(c, -10, 0, 0, 0) end, desc = "Move left"},
      {mod = { M.MOD }, key = "Right",         press = function(c) protectedResize(c, 10, 0, 0, 0) end, desc = "Move right"},
    },
  },

  {
    group = "client",
    bindings = {
      {mod = { M.MOD }, key = "f",                 press = function(c) c.fullscreen = not c.fullscreen; c:raise() end, desc = "Toggle fullscreen"},
      {mod = { M.MOD, M.SHIFT }, key = "c",        press = function(c) c:kill() end, desc = "Close"},
      {mod = { M.MOD }, key = "s",                 press = awful.client.floating.toggle, desc = "Toggle floating"},
      {mod = { M.MOD, M.CONTROL }, key = "Return", press = function(c) c:swap(awful.client.getmaster()) end, desc = "Move to master"},
      {mod = { M.MOD }, key = "o",                 press = function(c) c:move_to_screen() end, desc = "Move to screen"},
      {mod = { M.MOD }, key = "x",                 press = function(c) c.sticky = not c.sticky end, desc = "Toggle keep on top"},
      {mod = { M.MOD }, key = "n",                 press = function(c) c.minimized = true end, desc = "Minimize"},

      { mod = { M.MOD }, key = "m",
        press = function(c)
          c.maximized = not c.maximized
          if c.maximized then
            c:raise()
          end
        end,
        desc = "(Un)maximize"
      },

    },
  },
}
