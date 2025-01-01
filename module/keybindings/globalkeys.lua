
local awful = require("awful")
--local hotkeys_popup = require("awful.hotkeys_popup")
local defaults = require("module.default_programs")
local cmd = require("module.keybindings.commands")
local M = require("module.keybindings.modkeys")

return {
  {
    group = "awesome",
    bindings= {

      -- { mod = {M.MOD}, key = "s",
      --   press = hotkeys_popup.show_help,
      --   desc = "show help" },

      { mod = { M.MOD, M.ALT }, key = "r",
        press = awesome.restart,
        desc = "reload awesome" },

      { mod = { M.MOD, M.CONTROL }, key = "q",
        press = awesome.quit,
        desc = "quit awesome" } },
  },

  {
    group = "tag",
    bindings= {
      { mod = {M.MOD}, key = "Tab",
        press = awful.tag.history.restore,
        desc = "go back" },

      { mod = {M.MOD, M.SHIFT}, key = "l",
        press = function() awful.tag.viewnext() end,
        desc="view next tag" },

      { mod = {M.MOD, M.SHIFT}, key = "h",
        press = function() awful.tag.viewprev() end,
        desc="view prev tag" },

    },
  },

  {
    group = "client",
    bindings= {
      { mod = {M.MOD}, key = "j",
        press = function() awful.client.focus.byidx(1) end,
        desc = "focus next by index" },

      { mod = {M.MOD}, key = "k",
        press = function() awful.client.focus.byidx(-1) end,
        desc = "focus previous by index" },

      { mod = { M.MOD, M.SHIFT }, key = "j",
        press = function() awful.client.swap.byidx(1) end,
        desc = "swap with next client by index" },

      { mod = { M.MOD, M.SHIFT }, key = "k",
        press = function() awful.client.swap.byidx(-1) end,
        desc = "swap with previous client by index" },

      { mod = {M.MOD}, key = "u",
        press = awful.client.urgent.jumpto,
        desc = "jump to urgent client" },

      { mod = { M.MOD, "Control" }, key = "n",
        press = function()
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
        press = function() awful.spawn(defaults.terminal) end,
        desc = "open a terminal" },

      { mod = { M.MOD, M.SHIFT }, key = "Return",
        press = function() awful.spawn(defaults.tmux) end,
        desc = "open tmux" },

      { mod = { M.MOD, M.ALT }, key = "Return",
        press = function() awful.spawn(defaults.eclipse) end,
        desc = "open Eclipse" },

      { mod = {M.MOD}, key = "space",
        press = function() awful.spawn(defaults.runprompt) end,
        desc = "show dmenu" },

      { mod = { M.MOD, M.SHIFT }, key = "Tab",
        press = function() awful.spawn(defaults.windowswitcher) end,
        desc = "show window switcher"},

      { mod = { M.MOD, M.ALT }, key = "Escape",
        press = function() awful.spawn(defaults.powermenu) end,
        desc = "show powermenu" },

      { mod = { M.MOD, M.SHIFT }, key = "F12",
        press = function() awful.spawn(defaults.calculator) end,
        desc = "run calculator" },

      { mod = { M.MOD, M.ALT }, key = "m",
        press = function() awful.spawn.with_shell(defaults.xmouseless) end,
        desc = "run xmouseless" } },
  },

  {
    group = "layout",
    bindings= {
      { mod = {M.MOD}, key = "l",
        press = function() awful.tag.incmwfact(0.05) end,
        desc = "increase master width factor" },

      { mod = {M.MOD}, key = "h",
        press = function() awful.tag.incmwfact(-0.05) end,
        desc = "decrease master width factor" } },
  },

  {
    group = "mediakeys",
    bindings= {
      { key = "XF86MonBrightnessUp",
        press = function() cmd.increaseBrightness(5) end,
        desc = "+1% brightness" },

      { key = "XF86MonBrightnessDown",
        press = function() cmd.decreaseBrightness(5) end,
        desc = "-1% brightness" },

      { key = "XF86AudioRaiseVolume",
        press = function() cmd.increaseAudioVolume(5) end,
        desc = "+1% volume" },

      { key = "XF86AudioLowerVolume",
        press = function() cmd.decreaseAudioVolume(5) end,
        desc = "-1% volume" },

      { key = "XF86AudioMute",
        press = function() cmd.toggleAudioMute() end,
        desc = "mute audio" },

      { mod = { M.MOD, M.SHIFT }, key = "=",
        press = function() cmd.increaseAudioVolume(5) end,
        desc = "volume up" },

      { mod = { M.MOD, M.SHIFT }, key = "-",
        press = function() cmd.decreaseAudioVolume(5) end,
        desc = "volume down" },

      { mod = { M.MOD, M.SHIFT }, key = "BackSpace",
        press = function() cmd.toggleAudioMute() end,
        desc = "toggle mute" } },
  },

  {
    group = "cmus controls",
    bindings= {
      { mod = {M.MOD, M.SHIFT}, key = "Prior",
        press = cmd.cmusPrevTrack,
        desc = "prev track" },

      { mod = {M.MOD, M.SHIFT}, key = "Next",
        press = cmd.cmusNextTrack,
        desc = "next track" },

      { mod = {M.MOD, M.SHIFT}, key = "Insert",
        press = cmd.cmusPauseTrack,
        desc = "pause track" },

      { mod = {M.MOD, M.SHIFT}, key = "Delete",
        press = cmd.cmusStopTrack,
        desc = "stop track" },

      { mod = {M.MOD, M.SHIFT}, key = "Home",
        press = cmd.cmusVolumeIncrease,
        desc = "stop track" },

      { mod = {M.MOD, M.SHIFT}, key = "End",
        press = cmd.cmusVolumeDecrease,
        desc = "stop track" },

    },
  }
}

