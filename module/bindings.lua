
local awful = require("awful")
--local hotkeys_popup = require("awful.hotkeys_popup")
local defaults = require("module.default_programs")
local mdc = require("module.mediacontrols")
local M = require("module.modkeys")

return {
  {
    group = "awesome",
    bindings= {

      -- { mod = {M.MOD}, key = "s",
      --   action = hotkeys_popup.show_help,
      --   desc = "show help" },

      { mod = { M.MOD, M.ALT }, key = "r",
        action = awesome.restart,
        desc = "reload awesome" },

      { mod = { M.MOD, M.CONTROL }, key = "q",
        action = awesome.quit,
        desc = "quit awesome" } },
  },

  {
    group = "tag",
    bindings= {
      { mod = {M.MOD}, key = "Tab",
        action = awful.tag.history.restore,
        desc = "go back" } },
  },

  {
    group = "client",
    bindings= {
      { mod = {M.MOD}, key = "j",
        action = function() awful.client.focus.byidx(1) end,
        desc = "focus next by index" },

      { mod = {M.MOD}, key = "k",
        action = function() awful.client.focus.byidx(-1) end,
        desc = "focus previous by index" },

      { mod = { M.MOD, M.SHIFT }, key = "j",
        action = function() awful.client.swap.byidx(1) end,
        desc = "swap with next client by index" },

      { mod = { M.MOD, M.SHIFT }, key = "k",
        action = function() awful.client.swap.byidx(-1) end,
        desc = "swap with previous client by index" },

      { mod = {M.MOD}, key = "u",
        action = awful.client.urgent.jumpto,
        desc = "jump to urgent client" },

      { mod = { M.MOD, "Control" }, key = "n",
        action = function()
          local c = awful.client.restore()
          if c then
            c:emit_signal("request::activate", "key.unminimize", {raise = true})
          end
        end,
        desc = "restore minimized" } },
  },

  {
    group = "launcher",
    bindings= {
      { mod = {M.MOD}, key = "Return",
        action = function() awful.spawn(defaults.terminal) end,
        desc = "open a terminal" },

      { mod = { M.MOD, M.SHIFT }, key = "Return",
        action = function() awful.spawn(defaults.tmux) end,
        desc = "open tmux" },

      { mod = { M.MOD, M.ALT }, key = "Return",
        action = function() awful.spawn(defaults.eclipse) end,
        desc = "open Eclipse" },

      { mod = {M.MOD}, key = "space",
        action = function() awful.spawn(defaults.runprompt) end,
        desc = "show dmenu" },

      { mod = { M.MOD, M.SHIFT }, key = "space",
        action = function() awful.spawn(defaults.windowswitcher) end,
        desc = "show window switcher"},

      { mod = { M.MOD, M.ALT }, key = "Escape",
        action = function() awful.spawn(defaults.powermenu) end,
        desc = "show powermenu" },

      { mod = { M.MOD, M.SHIFT }, key = "F12",
        action = function() awful.spawn(defaults.calculator) end,
        desc = "run calculator" },

      { mod = { M.MOD, M.ALT }, key = "m",
        action = function() awful.spawn.with_shell(defaults.xmouseless) end,
        desc = "run xmouseless" } },
  },
  {
    group = "layout",
    bindings= {
      { mod = {M.MOD}, key = "l",
        action = function() awful.tag.incmwfact(0.05) end,
        desc = "increase master width factor" },

      { mod = {M.MOD}, key = "h",
        action = function() awful.tag.incmwfact(-0.05) end,
        desc = "decrease master width factor" } },
  },
  {
    group = "mediakeys",
    bindings= {
      { key = "XF86MonBrightnessUp",
        action = function() mdc.increaseBrightness(5) end,
        desc = "+1% brightness" },

      { key = "XF86MonBrightnessDown",
        action = function() mdc.decreaseBrightness(5) end,
        desc = "-1% brightness" },

      { key = "XF86AudioRaiseVolume",
        action = function() mdc.increaseAudioVolume(5) end,
        desc = "+1% volume" },

      { key = "XF86AudioLowerVolume",
        action = function() mdc.decreaseAudioVolume(5) end,
        desc = "-1% volume" },

      { key = "XF86AudioMute",
        action = function() mdc.toggleAudioMute() end,
        desc = "mute audio" },

      { mod = { M.MOD, M.SHIFT }, key = "=",
        action = function() mdc.increaseAudioVolume(5) end,
        desc = "volume up" },

      { mod = { M.MOD, M.SHIFT }, key = "-",
        action = function() mdc.decreaseAudioVolume(5) end,
        desc = "volume down" },

      { mod = { M.MOD, M.SHIFT }, key = "BackSpace",
        action = function() mdc.toggleAudioMute() end,
        desc = "toggle mute" } },
  },
}

