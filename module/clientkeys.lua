
local awful = require("awful")
local M = require("module.modkeys")

local function protectedResize(c, x, y, w, h)

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

return {
  {
    group = "Resize",
    bindings = {
      {mod = { M.MOD, M.SHIFT }, key = "Left", action = function(c) protectedResize(c, 0, 0, -10, 0) end, desc = "Resize left"},
      {mod = { M.MOD, M.SHIFT }, key = "Right",action = function(c) protectedResize(c, 0, 0, 10, 0) end, desc = "Resize right"},
      {mod = { M.MOD, M.SHIFT }, key = "Up",   action = function(c) protectedResize(c, 0, 0, 0, -10) end, desc = "Resize up"},
      {mod = { M.MOD, M.SHIFT }, key = "Down", action = function(c) protectedResize(c, 0, 0, 0, 10) end, desc = "Resize down"},
      {mod = { M.MOD }, key = "Down",          action = function(c) protectedResize(c, 0, 10, 0, 0) end, desc = "Move down"},
      {mod = { M.MOD }, key = "Up",            action = function(c) protectedResize(c, 0, -10, 0, 0) end, desc = "Move up"},
      {mod = { M.MOD }, key = "Left",          action = function(c) protectedResize(c, -10, 0, 0, 0) end, desc = "Move left"},
      {mod = { M.MOD }, key = "Right",         action = function(c) protectedResize(c, 10, 0, 0, 0) end, desc = "Move right"},
    },
  },
  {
    group = "Client",
    bindings = {
      {mod = { M.MOD }, key = "f",                 action = function(c) c.fullscreen = not c.fullscreen; c:raise() end, desc = "Toggle fullscreen"},
      {mod = { M.MOD, M.SHIFT }, key = "c",        action = function(c) c:kill() end, desc = "Close"},
      {mod = { M.MOD }, key = "s",                 action = awful.client.floating.toggle, desc = "Toggle floating"},
      {mod = { M.MOD, M.CONTROL }, key = "Return", action = function(c) c:swap(awful.client.getmaster()) end, desc = "Move to master"},
      {mod = { M.MOD }, key = "o",                 action = function(c) c:move_to_screen() end, desc = "Move to screen"},
      {mod = { M.MOD }, key = "t",                 action = function(c) c.ontop = not c.ontop end, desc = "Toggle keep on top"},
      {mod = { M.MOD }, key = "n",                 action = function(c) c.minimized = true end, desc = "Minimize"},
      {mod = { M.MOD }, key = "m",                 action = function(c) c.maximized = not c.maximized; c:raise() end, desc = "(Un)maximize"},
      {mod = { M.MOD, M.CONTROL }, key = "m",      action = function(c) c.maximized_vertical = not c.maximized_vertical; c:raise() end, desc = "(Un)maximize vertically"},
      {mod = { M.MOD, M.SHIFT }, key = "m",        action = function(c) c.maximized_horizontal = not c.maximized_horizontal; c:raise() end, desc = "(Un)maximize horizontally"},
    },
  },
}
