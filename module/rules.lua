local beautiful = require("beautiful")
local keys = require("module.keys")
local awful = require("awful")

local center_client = function(c)
  local geometry = screen[c.screen].workarea
  local width = c.width or 800
  local height = c.height or 600
  local x = geometry.x + (geometry.width - width) / 2
  local y = geometry.y + (geometry.height - height) / 2
  c:geometry({ x = x, y = y })
end

return {
  -- All clients will match this rule.
  { rule = { },
    properties = { border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = keys.clientkeys,
      buttons = keys.clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap+awful.placement.no_offscreen
    }
  },

  -- Floating clients.
  { rule_any = {
    instance = {
      "DTA",  -- Firefox addon DownThemAll.
      "copyq",  -- Includes session name in class.
      "pinentry",
    },
    class = {
      "Qalculate-gtk",
      "Pavucontrol",
      "Arandr",
      "Zeal",
      "Blueman-manager",
      "Gpick",
      "Kruler",
      "MessageWin",  -- kalarm.
      "Sxiv",
      "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
      "Wpa_gui",
      "veromix",
      "xtightvncviewer",
      "Dialog",
      "TaskTimer"
    },

    -- Note that the name property shown in xprop might be set slightly after creation of the client
    -- and the name shown there might not match defined rules here.
    name = {
      "Event Tester",  -- xev.
      "Eclipse Marketplace ",
      "Clocks",
    },
    role = {
      "AlarmWindow",  -- Thunderbird's calendar.
      "ConfigManager",  -- Thunderbird's about:config.
      "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
    }
  },
    properties = {
      floating = true,
      callback = center_client
    },
  },

  {
    rule_any = {
      type = {
        "normal"
      }
    },
    properties = {
      titlebars_enabled = true
    }
  },

  {
    rule_any = {
      name = { "Lutris" },
      class = {"Zathura"}
    },
    properties = {
      titlebars_enabled = false
    }
  },

  {
    rule_any = {
      class = {"mpv"},
    },
    properties = {
      size_hints_honor=false,
      titlebars_enabled=false
    }
  },

  { 
    rule_any = {
      class = {"st-256color"},
      name = {"st"} },
    properties = {
      size_hints_honor=false,
      titlebars_enabled=false
    }
  },

  -- Set Firefox to always map on the tag named "2" on screen 1.
  -- { rule = { class = "Firefox" },
  --   properties = { screen = 1, tag = "2" } },

}

