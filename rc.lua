-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
--local signals = require("module.signals")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
  naughty.notify({ preset = naughty.config.presets.critical,
    title = "Oops, there were errors during startup!",
    text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal("debug::error", function (err)
    -- Make sure we don't go into an endless error loop
    if in_error then return end
    in_error = true

    naughty.notify({ preset = naughty.config.presets.critical,
      title = "Oops, an error happened!",
      text = tostring(err) })
    in_error = false
  end)
end
-- }}}
awful.spawn.with_shell("$XDG_CONFIG_HOME/awesome/autostart")
local init_programs = { "nm-applet" }
-- run once every time Awesome is started
for _, cmd in ipairs(init_programs) do
  awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
end

-- Themes define colours, icons, font and wallpapers.
beautiful.init("/home/rss/.config/awesome/theme/theme.lua")

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts = require("module.layouts")
awful.layout.layouts = layouts

-- Create a wibox for each screen and add it

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
-- Key bindings
local keys = require("module.keys")
root.keys(keys.globalkeys)
root.buttons(keys.mousebindings)

-- Rules to apply to new clients (through the "manage" signal).
local rules = require("module.rules")
awful.rules.rules = rules

-- Signals
local signals = require("module.signals")
for _, conn in ipairs(signals) do
  if conn.signal then
    print(conn.signal)
    conn.call(conn.signal, conn.callback)
  else
    conn.call(conn.callback)
  end
end
